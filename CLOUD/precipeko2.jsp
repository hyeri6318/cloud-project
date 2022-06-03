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
            String jdbcDriver ="jdbc:mysql://localhost:3306/TestDB?serverTimezone=UTC"; 
            String dbUser ="tester"; //mysql id
            String dbPass ="1234"; //mysql password
            String query ="SELECT RNUM, TITLE, ID, TIME, VIEW, RECIPE FROM PRECIPE WHERE RNUM=" + rnum + ";"; //query
        
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
                    String title = rs.getString("title");
                    String id = rs.getString("id");
                    String time = rs.getString("time");
                    int view = rs.getInt("view");
                    String recipe = rs.getString("recipe");
                    view++;
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
            onClick=location.href='precipeuproad.html'>UPROAD PRECIPE</a>
            <a class="btn" style="
                text-decoration: none;
                margin-left:50px;
                color:white;
                cursor:pointer;"
            onClick=location.href='profile.html'>PROFILE</a>
        </div>
    </div>
    
    

            <table style="
                width=100%;
                cellpadding=0;
                cellspacing=0;
                border=0;
                text-align: center;
                margin: auto;
                margin-top: 60px;
                font-size: 1.4rem;
            ">
     <tr style="text-align:center;">
      <td>내 용</td>
     </tr>
    </table>
   <table style="
                width=200%;
                cellpadding=0;
                cellspacing=0;
                border=0;
                text-align: center;
                margin: auto;
                margin-top: 60px;
                font-size: 1.4rem;
            ">
     <tr>
      <td align="center" width="400">글번호</td>
      <td width="319"><%=rnum%></td>
     </tr>
	 <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
    <tr>
      <td align="center" width="76">제목</td>
      <td width="319"><%=title%></td>
     </tr>
	 <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
    <tr>
      <td align="center" width="76">이름</td>
      <td width="319"><%=id%></td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
    <tr>
      <td align="center" width="76">소요시간</td>
      <td width="319"><%=time%></td>
     </tr>
      <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
    <tr>
      <td align="center" width="76">조회수</td>
      <td width="319"><%=view%></td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
                <tr>

                   <td width="399" colspan="1" height="200"><%=recipe %>
                </tr>


<%
    query="UPDATE PRECIPE SET VIEW=" + view + " WHERE RNUM=" + rnum + ";";
    stmt.executeUpdate(query);
    rs.close();
    stmt.close();
    conn.close();
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
	<input type=button value="답글">
	<input type=button value="목록" onClick=location.href='precipeko.jsp'>
	<input type=button value="수정">
	<input type=button value="삭제">
      <td width="0">&nbsp;</td>
     </tr>
    </table>


    </body>
</html>