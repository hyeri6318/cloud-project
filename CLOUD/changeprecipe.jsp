<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="java.lang.String" %>
<%@ page import ="java.sql.*"%>
<% request.setCharacterEncoding("utf-8"); %>

<%
        // 업로드할 클래스 이름 지정
        Class.forName("com.mysql.cj.jdbc.Driver"); 
        Connection conn =null;
        Statement stmt =null;
        ResultSet rs =null;
        int rnum = Integer.parseInt(request.getParameter("rnum"));
        

        try{
            
            // Driver로부터 데이터베이스와의 Connection을 얻기 위함
            String jdbcDriver ="jdbc:mysql://localhost:3306/ProjectDB?serverTimezone=UTC"; 
            String dbUser ="cloud"; //mysql id
            String dbPass ="5678"; //mysql password
            String query ="SELECT * FROM PRECIPE WHERE RNUM=" + rnum + ";"; //query
        
            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

            // Connection 객체가 생성되면 SQL 문을 데이터베이스로 전송하기 위함
            stmt=conn.createStatement();

            //if(rs.next()){
            //    total = rs.getInt(1);
            //}

            // user 테이블로부터 사용자 아이디와 패스워드 정보 추출
            rs = stmt.executeQuery(query);

                if(rs.next()){
                    //int rnum = rs.getInt("rnum");
                    String title = rs.getString("TITLE");
                    String time = rs.getString("TIME");
                    int view = rs.getInt("VIEW");
                    String ingre = rs.getString("INGRE");
                    String recipe = rs.getString("RECIPE");
                   // recipe=recipe.replace("\r\n","<br>");

                    String cate = rs.getString("CATE");
                    
                    String weather = rs.getString("WEATHER");
                    
                    String korea = "korea";
                    String chinese = "chinese";
                    String japanese = "japanese";
                    String western = "western";

                    String sunny = "sunny";
                    String cloud = "cloud";
                    String fog = "fog";
                    String rain = "rain";
                    String snow = "snow";
            // TODO
%>


<html>
    <head>
    <link href="style.css" rel="stylesheet" type="precipeko.css">
    <title>한식</title>
    </head>
    <body style="background:rgb(77, 76, 76);">
    <div class="head" style="
        position: sticky;
        top: 0;
        left: 0;
        right: 0;
        background-color: rgba(0, 0, 0, 0.2);
        backdrop-filter: blur(6px);
        padding: 0.8rem;
        display: flex;
        justify-content: space-between;
    ">
        <h3 style="margin: 0;
            font-size: 2.5rem;
            color: white;
        ">
            세상에 나쁜 요리는 없다
        </h3>
        <div class="menu" style="
            padding: 0;
            margin: 0;
            list-style: none;
            font-size: 1.5rem;
        ">
            <a class="btn" style="
                text-decoration: none;
                margin-left:50px;
                color:white;
                cursor:pointer;
            ">RECIPE</a>
            <a class="btn" style="
                text-decoration: none;
                margin-left:50px;
                color:white;
                cursor:pointer;
            ">OWN RECIPE</a>
            <a class="btn" style="
                text-decoration: none;
                margin-left:50px;
                color:white;
                cursor:pointer;
            ">RANKING</a>
            <a class="btn" style="
                text-decoration: none;
                margin-left:50px;
                color:white;
                cursor:pointer;"
            onClick=location.href='profile.html'>PROFILE</a>
        </div>
    </div>
    
            <table style="
            
                text-align: center;
                margin: auto;
                margin-top: 60px;
                font-size: 1.4rem;
            ">
     <tr style="text-align:center;">
      <td>내 용</td>
     </tr>
    </table>
    <form action="changeprecipe_ok.jsp" method="post">
   <table style="
                text-align: center;
                margin: auto;
                margin-top: 60px;
                font-size: 1.4rem;
            ">
     <tr>
        <td align="center" width="400">글번호</td>
        <td width="319"><%=rnum%></td>
        <input type="hidden" name="rnum" value=<%=rnum%> />
       </tr>
    <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
    <tr>
      <td align="center" width="76">제목</td>
      <td><input type="text" name="title" value="<%=title%>"></td>
     </tr>
    <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>

      <td align="center" width="76">소요시간</td>
      <td><input type="text" name="time" value="<%=time%>"></td>
     </tr>
      <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>

      <td align="center" width="76">카테고리</td>
        <td>
        <% if(cate.equals("korea")){%>
        <input type="radio" name="cate" value="<%=korea%>"checked> 한식
        <%} else{%>
            <input type="radio" name="cate" value="<%=korea%>"> 한식
        <%}

        if(cate.equals("chinese")){%>
        <input type="radio" name="cate" value="<%=chinese%>"checked> 중식
        <%} else {%>
            <input type="radio" name="cate" value="<%=chinese%>"> 중식
        <%}

        if(cate.equals("western")){%>
        <input type="radio" name="cate" value="<%=western%>"checked> 양식
        <%} else {%>
            <input type="radio" name="cate" value="<%=western%>"> 양식
            <%}

        if(cate.equals("japanese")){%>
        <input type="radio" name="cate" value="<%=japanese%>"checked> 일식
        <%}else{%>
            <input type="radio" name="cate" value="<%=japanese%>"> 일식
        <%}%>
        </td>
    </tr>
    <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>

      <td align="center" width="76">날씨</td>
        <td>
            <% if(weather.equals("sunny")){%>
                <input type="radio" name="weather" value="<%=sunny%>" checked> 맑음
                <%} else{%>
                    <input type="radio" name="weather" value="<%=sunny%>">맑음
                <%}
                if(weather.equals("cloud")){%>
                <input type="radio" name="weather" value="<%=cloud%>"checked> 흐림
                <%} else{%>
                    <input type="radio" name="weather" value="<%=cloud%>"> 흐림
                <%}
                if(weather.equals("rain")){%>
                <input type="radio" name="weather" value="<%=rain%>"checked> 비
                <%} else{%>
                    <input type="radio" name="weather" value="<%=rain%>"> 비
                <%}
                if(weather.equals("snow")){%>
                <input type="radio" name="weather" value="<%=snow%>"checked> 눈
                <%} else{%>
                    <input type="radio" name="weather" value="<%=snow%>"> 눈
                    <%}
                    if(weather.equals("fog")){%>
                <input type="radio" name="weather" value = "<%=fog%>"checked> 안개
                <%} else{%>
                    <input type="radio" name="weather" value = "<%=fog%>"> 안개
                <%}%>
        </td>
        <td>&nbsp;</td>
      </tr>
      <tr height="1" bgcolor="#dddddd">
        <td colspan="4"></td>
      </tr>

    <tr>
      <td align="center" width="76">조회수</td>
      <td width="319"><%=view%></td>
      <input type="hidden" name="view" value=<%=view%> />
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr><tr>
      <td align="center" width="76">재료</td>
      <td><input type="text" name="ingre" value="<%=ingre%>"></td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
                <tr>

                   <td><textarea name="recipe"><%=recipe%></textarea></td>
                </tr>


<%
            
            }
    } catch(SQLException ex) {
        out.println(ex.getMessage());
        ex.printStackTrace();
    }
%>

     <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
     <tr height="1" bgcolor="#82B5DF"><td colspan="4" width="407"></td></tr>
     <tr align="center">
      <td width="0">&nbsp;</td>
      <td colspan="2" width="399">
   <input type=submit value="레시피 수정">
   <input type=button value="취소" onClick=location.href='precipe_list.jsp'>
      <td width="0">&nbsp;</td>
     </tr>
    </table>
            
        </form>
    </body>
</html>