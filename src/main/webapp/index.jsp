<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // district 파라미터가 있으면 search.jsp로 리다이렉트
    String district = request.getParameter("district");
    if (district != null && !district.trim().isEmpty()) {
        response.sendRedirect("search.jsp?district=" + district);
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관광 명소 찾기 서비스</title>
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
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            text-align: center;
        }
        .user-info {
            text-align: right;
            color: #999;
            font-size: 14px;
            margin-bottom: 20px;
        }
        .title {
            font-size: 32px;
            font-weight: bold;
            margin: 100px 0 50px 0;
            color: #333;
        }
        .main-nav {
            display: flex;
            justify-content: center;
            margin: 50px 0;
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 8px;
        }
        .nav-btn {
            text-decoration: none;
            padding: 10px 20px;
            margin: 0 5px;
            border-radius: 4px;
            transition: all 0.3s ease;
            background-color: #747474;
            color: white;
        }
        .nav-btn:hover, .nav-btn.active {
            font-weight: bold;
        }
        .all-btn:hover {
            background-color: #000000;
            color: white;
        }
        .seoul-btn:hover {
            background-color: #FF0000;
            color: white;
        }
        .chungcheong-btn:hover {
            background-color: #FFFF00;
            color: black;
        }
        .jeonla-btn:hover, .jeonla-btn.active {
            background-color: #00FF00;
            color: white;
        }
        .gyeongsang-btn:hover {
            background-color: #87CEEB;
            color: white;
        }
        .gangwon-btn:hover {
            background-color: #0000FF;
            color: white;
        }
        .jeju-btn:hover {
            background-color: #FFC0CB;
            color: white;
        }
        .second-nav {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .second-nav a {
            text-decoration: none;
            padding: 5px 15px;
            margin: 0 5px;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        .second-nav a.all {
            color: #000000;
        }
        .second-nav a.seoul {
            color: #FF6B6B;
        }
        .second-nav a.chungcheong {
            color: #FFD93D;
        }
        .second-nav a.jeonla {
            color: #6BCB77;
        }
        .second-nav a.gyeongsang {
            color: #4D96FF;
        }
        .second-nav a.gangwon {
            color: #9B72AA;
        }
        .second-nav a.jeju {
            color: #333;
        }
        .second-nav a:hover {
            font-weight: bold;
        }
        footer {
            margin-top: 100px;
            text-align: center;
            color: #999;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="title">관광 명소 찾기 서비스</h1>
        
        <div class="main-nav">
            <a href="search.jsp?district=전체" class="nav-btn all-btn">전체</a>
            <a href="search.jsp?district=수도권" class="nav-btn seoul-btn">수도권</a>
            <a href="search.jsp?district=충청권" class="nav-btn chungcheong-btn">충청권</a>
            <a href="search.jsp?district=전라권" class="nav-btn jeonla-btn">전라권</a>
            <a href="search.jsp?district=경상권" class="nav-btn gyeongsang-btn">경상권</a>
            <a href="search.jsp?district=강원권" class="nav-btn gangwon-btn">강원권</a>
            <a href="search.jsp?district=제주권" class="nav-btn jeju-btn">제주권</a>
        </div>
        <footer>
            https://korean.visitkorea.or.kr/main/area.do
        </footer>
    </div>
</body>
</html>
