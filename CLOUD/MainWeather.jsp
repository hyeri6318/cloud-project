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

<h1><%= weatherForecast %></h1>