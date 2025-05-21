<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%
    request.setCharacterEncoding("UTF-8");
    String district = request.getParameter("district");
    if (district == null || district.trim().isEmpty() || district.equals("전체")) {
        district = "전체";
    }
    
    // 검색 키워드 가져오기
    String keyword = request.getParameter("keyword");
    boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
    
    // CSV 파일 경로
    String csvFilePath = "C:\\Java\\OPEN API\\travel.csv";
    
    // 여행지 데이터를 저장할 리스트
    List<Map<String, String>> travelList = new ArrayList<>();
    
    // CSV 파일 읽기
    try (BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(csvFilePath), StandardCharsets.UTF_8))) {
        String line;
        boolean firstLine = true; // 헤더 건너뛰기 위한 변수
        
        while ((line = br.readLine()) != null) {
            if (firstLine) {
                firstLine = false;
                continue; // 첫 번째 줄(헤더) 건너뛰기
            }
            
            String[] values = line.split(",");
            if (values.length >= 6) {
                Map<String, String> travelItem = new HashMap<>();
                travelItem.put("no", values[0]);
                travelItem.put("district", values[1]);
                travelItem.put("title", values[2]);
                travelItem.put("description", values[3]);
                travelItem.put("addr", values[4]);
                travelItem.put("tel", values[5]);
                
                // 지역 필터링
                if (district.equals("전체") || travelItem.get("district").equals(district)) {
                    // 키워드 필터링
                    if (!hasKeyword || 
                        travelItem.get("title").toLowerCase().contains(keyword.toLowerCase()) || 
                        travelItem.get("addr").toLowerCase().contains(keyword.toLowerCase()) || 
                        travelItem.get("tel").toLowerCase().contains(keyword.toLowerCase())) {
                        travelList.add(travelItem);
                    }
                }
            }
        }
    } catch (IOException e) {
        out.println("<p>CSV 파일을 읽는 중 오류가 발생했습니다: " + e.getMessage() + "</p>");
        e.printStackTrace();
    }
    
    // 페이지네이션 처리
    int currentPage = 1;
    String pageStr = request.getParameter("page");
    if (pageStr != null && !pageStr.trim().isEmpty()) {
        try {
            currentPage = Integer.parseInt(pageStr);
            if (currentPage < 1) currentPage = 1;
        } catch (NumberFormatException e) {
            currentPage = 1;
        }
    }
    
    int itemsPerPage = 4; // 한 페이지에 4개씩 표시
    int totalItems = travelList.size();
    int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
    
    if (currentPage > totalPages && totalPages > 0) {
        currentPage = totalPages;
    }
    
    int startIdx = (currentPage - 1) * itemsPerPage;
    int endIdx = Math.min(startIdx + itemsPerPage, totalItems);
    
    List<Map<String, String>> currentPageItems = new ArrayList<>();
    if (startIdx < totalItems) {
        currentPageItems = travelList.subList(startIdx, endIdx);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관광지 권역별 검색 페이지</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Malgun Gothic', sans-serif;
        }
        body {
            background-color: #f5f5f5;
        }
        .container {
            width: 100%;
            max-width: 650px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }
        .back-btn {
            text-decoration: none;
            color: #333;
            display: flex;
            align-items: center;
            font-size: 14px;
        }
        .back-btn:hover {
            text-decoration: underline;
        }
        .title {
            font-size: 18px;
            font-weight: bold;
            margin-left: 10px;
        }
        .search-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        .search-form {
            margin-bottom: 15px;
            display: flex;
        }
        .search-form input[type="text"] {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px 0 0 4px;
            font-size: 14px;
        }
        .search-form button {
            padding: 10px 15px;
            background-color: #747474;
            color: white;
            border: none;
            border-radius: 0 4px 4px 0;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .search-form button:hover {
            background-color: #000000;
        }
        .search-summary {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
            font-size: 14px;
            color: #666;
        }
        .search-form button {
            width: 80px;
            padding: 10px 0;
            background-color: #747474;
            color: white;
            border: none;
            border-radius: 0 4px 4px 0;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-left: 0;
        }
        .search-form button:hover {
            background-color: #000000;
        }
        .result-table {
            width: 100%;
            border-collapse: collapse;
        }
        .result-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
        }
        .result-item:last-child {
            border-bottom: none;
        }
        .item-title {
            font-size: 14px;
        }
        .item-desc {
            font-size: 12px;
            color: #666;
            margin-top: 3px;
        }
        .view-btn {
            display: inline-block;
            padding: 5px 10px;
            background-color: #f0f0f0;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-decoration: none;
            color: #333;
            font-size: 12px;
            white-space: nowrap;
        }
        .view-btn:hover {
            background-color: #e0e0e0;
        }
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            gap: 5px;
        }
        .pagination a {
            display: inline-block;
            padding: 5px 10px;
            text-decoration: none;
            color: #333;
            font-size: 14px;
        }
        .pagination a.active {
            font-weight: bold;
        }
        .pagination a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <a href="index.jsp" class="back-btn">< 메인 페이지로</a>
            <div class="title"><%= district %></div>
        </div>
        
        <div class="search-card">
            <form class="search-form" action="search.jsp" method="get">
                <input type="hidden" name="district" value="<%= district %>">
                <input type="text" name="keyword" placeholder="관광지명, 주소 또는 전화번호로 검색" value="<%= hasKeyword ? keyword : "" %>">
                <button type="submit">검색</button>
            </form>
            
            <div class="search-summary">
                <% if (hasKeyword) { %>
                    <div>"<strong><%= keyword %></strong>" 검색 결과 (<%= travelList.size() %>건)</div>
                <% } else { %>
                    <div><strong><%= district %></strong> 관광지 정보 (<%= travelList.size() %>건)</div>
                <% } %>
            </div>
            
            <% if (currentPageItems.isEmpty()) { %>
                <div class="result-item empty-result">
                    <div class="item-title">검색 결과가 없습니다.</div>
                    <div class="item-desc">다른 키워드나 지역으로 검색해 보세요.</div>
                </div>
            <% } else { 
                for (Map<String, String> travel : currentPageItems) { %>
                    <div class="result-item">
                        <div>
                            <div class="item-title"><%= travel.get("title") %></div>
                            <div class="item-info">
                                <% if (travel.get("addr") != null && !travel.get("addr").trim().isEmpty()) { %>
                                    <div class="item-address"><i>📍</i> <%= travel.get("addr") %></div>
                                <% } %>
                                <% if (travel.get("tel") != null && !travel.get("tel").trim().isEmpty()) { %>
                                    <div class="item-tel"><i>📞</i> <%= travel.get("tel") %></div>
                                <% } %>
                            </div>
                        </div>
                        <a href="detail.jsp?id=<%= travel.get("no") %>" class="view-btn">상세보기</a>
                    </div>
                <% } 
            } %>
            
            <% if (totalPages > 1) { %>
                <div class="pagination">
                    <% for (int i = 1; i <= Math.min(5, totalPages); i++) { %>
                        <a href="search.jsp?district=<%= district %>&page=<%= i %>" <%= (i == currentPage) ? "class='active'" : "" %>><%= i %></a>
                    <% } %>
                    <% if (totalPages > 5) { %>
                        <a href="search.jsp?district=<%= district %>&page=<%= Math.min(currentPage + 5, totalPages) %>">▶</a>
                    <% } %>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
