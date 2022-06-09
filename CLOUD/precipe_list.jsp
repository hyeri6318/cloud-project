<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="java.lang.String" %>
<% request.setCharacterEncoding("utf-8"); %>

<%-- 
    담당자 : 이혜리
    로그인한 사용자가 작성한 개인 레시피 목록을 보여준다.
 --%>

<html>
    <head>
    <link href="style.css" rel="stylesheet" type="precipeko.css">
    <title>한식</title>
    </head>
     <link href="style.css" rel="stylesheet" type="precipeko.css">
    <title>한식</title>
    </head>
       <body style="background:white;">
    <div class="head" style="
        position: sticky;
        top: 0;
        left: 0;
        right: 0;
        background-color: rgba(226, 226, 202, 0.80);
        backdrop-filter: blur(6px);
        padding: 0.8rem;
        display: flex;
        justify-content: space-between;
    ">
        <h3 style="margin: 0;
            font-size: 2.5rem;
            color: black;
            cursor:pointer;
        "><a style="float: left;" onCLick = "location.href='main.jsp'">세상에 나쁜 요리는 없다 </a>
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
                color:black;
                cursor:pointer;"
                onClick=location.href='standard.html'>RECIPE</a>
            <a class="btn" style="
                text-decoration: none;
                margin-left:50px;
                color:black;
                cursor:pointer;"
                onClick=location.href='precipe.html'>OWN RECIPE</a>
            <a class="btn" style="
                text-decoration: none;
                margin-left:50px;
                color:black;
                cursor:pointer;"
                onClick=location.href='standardranking.jsp'>RANKING</a>
            <a class="btn" style="
                text-decoration: none;
                margin-left:50px;
                color:black;
                cursor:pointer;"
            onClick=location.href='profile.jsp'>PROFILE</a>
            <a class="btn" style="
                text-decoration: none;
                margin-left:50px;
                color:black;
                cursor:pointer;"
            onClick=location.href='logout.jsp'>LOGOUT</a>
        </div>
    </div>

    <%

    String id=(String)session.getAttribute("id");
        // 업로드할 클래스 이름 지정
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
            String query ="select * from PRECIPE WHERE ID = '"+id+"'"; //query
        
            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

            // Connection 객체가 생성되면 SQL 문을 데이터베이스로 전송하기 위함
            stmt=conn.createStatement();
            rs = stmt.executeQuery(query);
    %>

            <h1 style="
                    margin-top: 60px;
                    margin-bottom: 100px;
                    margin-left: 30px;
                    color: white;
                ">
                    작성한 레시피</h1>

            <table style="
                text-align: center;
                margin: auto;
                margin-top: 60px;
                font-size: 1.4rem;
            ">
            <tr height="5"><td width="5"></td></tr>
            <td width="10%">번호</td>
            <td width="60%">제목</td>
            <td width="10%">소요시간</td>
            <td width="10%">조회수</td>

    <%
            if(total!=0){
    %>
            <tr align="center" bgcolor="#FFFFFF" height="30">
           <td colspan="6">등록된 글이 없습니다.</td>
           </tr>
    <%
            }else{
                while(rs.next()){
                    int rnum = rs.getInt("rnum");
                    String title = rs.getString("title");
                    String time = rs.getString("time");
                    int view = rs.getInt("view");
    %>
                    <tr height="25" align="center" >
                       
                       <td><%=rnum %></td>
                       <td align="left"><a href="changeprecipe.jsp?rnum=<%=rnum %>"><%=title %></td>
                       <td align="center"><%=time %></td>
                       <td align="center"><%=view %></td>
                       <td>&nbsp;</td>
                    </tr>
                    <tr height="1" bgcolor="#D2D2D2"><td colspan="6"></td></tr>
    <%
                }
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch(SQLException ex) {
            out.println(ex.getMessage());
            ex.printStackTrace();
        }
    %>
    </body>
</html>