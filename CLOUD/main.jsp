<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.io.InputStreamReader" %>
<%@ page import = "java.io.BufferedReader"%>
<%@ page import = "java.net.URL"%>
<%@ page import = "java.sql.Date"%>
<%@ page import = "java.util.Scanner"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "org.json.simple.JSONArray"%>
<%@ page import = "org.json.simple.JSONObject"%>
<%@ page import = "org.json.simple.parser.JSONParser"%>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="java.lang.String" %>
<% request.setCharacterEncoding("utf-8"); %>

<!--
    담당자 : 이혜리
    SFR-400 ~ SFR-403 : 메인페이지로서 표준 레시피 조회, 개인 레시피 조회, 인기순위 조회, 프로필 조회, 로그아웃을 할 수 있도록 구현한다.
                        개인 레시피에 저장되어 있는 날씨 정보를 바탕으로 날씨별 요리를 추천하도록 구현한다.
 -->

<%
String weatherForecast = null;
try {
    //TODO: 위도랑 경도 db에서 끌어오기, 아래는 동의대학교를 기준으로 임시 설정
    String lat = "35.1418";  //경도 임시 설정
    String lon = "129.0304";   //위도 임시 설정
    String serviceKey = "47671a7fbb639f3ccb421202df1964b4"; //api key
    // OpenWeather에서 JSON 파일 받아오기
    String URLStr = "https://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + lon + "&appid=" + serviceKey;
    //url 객체 생성
    URL url = new URL(URLStr);
    BufferedReader bf;
    String line = null;
    String result = null;
    // openStream 메소드로 날씨 정보 받아오기
    bf = new BufferedReader(new InputStreamReader(url.openStream()));
    // Json Parser 만들기
    JSONParser jsonParser = new JSONParser();
    // 객체화
    JSONObject jsonObj = (JSONObject) jsonParser.parse(bf);
    //weather 배열에서 0번째 순서 결과 받아오기
    JSONObject weather = (JSONObject) ((JSONArray) jsonObj.get("weather")).get(0);
    bf.close();
    //description에서 날씨 뽑아오기
    String weatherString =null;
    //weatherString = (String) weather.get("description");
    weatherString = (String) weather.get("main");
    //날씨를 sunny, cloud, rain, fog, snow로 변환
    if(weatherString.equals("Clear")){
        weatherForecast = "sunny";
    }else if(weatherString.equals("Clouds")){
        weatherForecast = "cloud";
    }else if(weatherString.equals("Drizzle") || weatherString.equals("Rain") || weatherString.equals("Thunderstorm")){
        weatherForecast = "rain";
    }else if(weatherString.equals("Mist") || weatherString.equals("Smoke") || weatherString.equals("Haze") || weatherString.equals("Dust") || weatherString.equals("Fog") || weatherString.equals("Sand") || weatherString.equals("Ash") || weatherString.equals("Squall") || weatherString.equals("Tornado")){
        weatherForecast = "fog";
    }else if(weatherString.equals("Snow")){
        weatherForecast = "snow";
    }
} catch (Exception e) {
    System.out.println(e.getMessage());
}
%>




<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <title>세나요</title>
        <link rel="stylesheet" type="text/css" href="main.css">
    </head>

    <body>
        <form method="get" action="search.jsp">
            <div class="head">
                <h3 style="
                    margin: 0;
                    font-size: 2.5rem;
                    color: black;
                    cursor:pointer;
                "><a style="float: left;" onCLick = "location.href='main.jsp'">세상에 나쁜 요리는 없다 </a>
                </h3>
                <div class="menu">
                    <a class="btn" onCLick = "location.href='standard.html'">RECIPE</a>
                    <a class="btn" onClick ="location.href='precipe.html'">OWN RECIPE</a>
                    <a class="btn" onclick="location.href='standardranking.jsp'">RANKING</a>
                    <a class="btn" onClick="location.href='profile.jsp'">PROFILE</a>
                    <a class="btn" onClick="location.href='logout.jsp'">LOGOUT</a>
                </div>
            </div>
            <div style="height: 100px;">&nbsp;</div>


            <div class="wrap">
                <div class="body">
                    <div class="searchArea">
                        <input type="search" name="search" placeholder="검색하고 싶은 재료를 입력하세요">
                        <button type="submit" class="btn_search">검색</button>
                    </div>
                        <div style="height: 20px;">&nbsp;</div>
                        <h1 style="
                        color: black;
                        text-align: center;
                        ">현재 날씨 : <%= weatherForecast %></h1>
                        
                        <%
                        Class.forName("com.mysql.cj.jdbc.Driver"); 
                        Connection conn =null;
                        Statement stmt =null;
                        ResultSet rs =null;
                        int total = 0; 
                        try{
                             // Driver로부터 데이터베이스와의 Connection을 얻기 위함
                            String jdbcDriver ="jdbc:mysql://localhost:3306/ProjectDB?serverTimezone=UTC"; 
                            String dbUser ="cloud"; //mysql id
                            String dbPass ="5678"; //mysql password
                            String query ="select RNUM, TITLE, ID, TIME, VIEW from PRECIPE where WEATHER='"+weatherForecast+"' order by VIEW DESC"; //query
        
                            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

                            // Connection 객체가 생성되면 SQL 문을 데이터베이스로 전송하기 위함
                            stmt=conn.createStatement();

                            // user 테이블로부터 사용자 아이디와 패스워드 정보 추출
                            rs = stmt.executeQuery(query);
                        %>
                <table style="
                width: 120%;
                text-align: center;
                margin: auto;
                margin-top: 30px;
                font-size: 1.5rem;
                color: black;
            ">
            <tr height="1" bgcolor="#D2D2D2"><td colspan="6"></td></tr>
            <tr height="1"><td width="5"></td></tr>
            <td width="10%">번호</td>
            <td width="60%">제목</td>
            <td width="10%">작성자</td>
            <td width="10%">소요시간</td>
            <td width="10%">조회수</td>
            <tr height="1" bgcolor="#D2D2D2"><td colspan="6"></td></tr>

<%
            while(rs.next()){
                    int rnum = rs.getInt("rnum");
                    String title = rs.getString("title");
                    String id = rs.getString("id");
                    String time = rs.getString("time");
                    int view = rs.getInt("view");

                    %>
                    <tr height="25" align="center" >
                       
                       <td><%=rnum %></td>
                       <td align="center"><a href="weather_precipe.jsp?rnum=<%=rnum %>" style="
                        text-decoration: none;
                        color: black;
                        "><%=title %></td>
                       <td align="center"><%=id %></td>
                       <td align="center"><%=time %></td>
                       <td align="center"><%=view %></td>
                       <td>&nbsp;</td>
                    </tr>
                    <tr height="1" bgcolor="#D2D2D2"><td colspan="6"></td></tr>
    <%
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch(SQLException ex) {
            out.println(ex.getMessage());
            ex.printStackTrace();
        }

            // TODO
    %>

                </div>
        </div>
    </form>
    </body>
</html>