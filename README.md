# 관광지 정보 시스템

관광지 정보를 조회하고 검색할 수 있는 콘솔 애플리케이션입니다.

## 기능

1. 전체 관광지 목록 조회 (페이지)
2. 권역별 관광지 조회
3. 관광지 검색

## 프로젝트 구조

```
travel-app/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── travel/
│       │           ├── app/
│       │           │   └── TravelApp.java
│       │           ├── dao/
│       │           │   └── TravelDao.java
│       │           ├── service/
│       │           │   └── TravelService.java
│       │           └── vo/
│       │               └── TravelVO.java
│       └── resources/
│           ├── application.properties
│           └── data/
│               └── travel.csv
├── lib/
│   └── mysql-connector-j-8.0.xx.jar
├── pom.xml
└── README.md
```

## 추가사항항

- 웹사이트로도 실행 가능하도록 구현 예정
- 웹사이트 프로그램 예상으론 tomcat 및 Spring boot 프로그램으로 구현 예정

## 실행 방법

1. 데이터베이스 설정
   - MySQL 서버가 실행 중이어야 합니다
   - travel_db 데이터베이스가 생성되어 있어야 합니다

2. 프로그램 컴파일
```bash
javac -cp "lib/*" -encoding UTF-8 -d target/classes src/main/java/com/travel/**/*.java
```

3. 프로그램 실행
```bash
java -cp "target/classes;lib/*" com.travel.app.TravelApp
