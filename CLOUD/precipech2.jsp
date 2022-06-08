<%-- 
    담당자 : 이재혁
    SFR-WM506 : 레시피를 확인할 수 있도록 한다.
    SFR-WM507 : 댓글을 작성할 수 있게 한다.
 --%>
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
            String query ="SELECT RNUM, TITLE, ID, TIME, VIEW, INGRE, RECIPE FROM PRECIPE WHERE RNUM=" + rnum + ";"; //query
        
            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

            // Connection 객체가 생성되면 SQL 문을 데이터베이스로 전송하기 위함
            stmt=conn.createStatement();

            // user 테이블로부터 사용자 아이디와 패스워드 정보 추출
            rs = stmt.executeQuery(query);

                if(rs.next()){
                    String title = rs.getString("title");
                    String id = rs.getString("id");
                    String time = rs.getString("time");
                    int view = rs.getInt("view");
                    String ingre = rs.getString("ingre");
                    String recipe = rs.getString("recipe");
                    view++;
%>


<html>
    <head>
    <link href="style.css" rel="stylesheet">
    <title>중식</title>
    </head>
    <body style="background: white;">

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
        "><a style="float: left;" onCLick = "location.href='main.html'">
            세상에 나쁜 요리는 없다</a>
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
            onCLick = "location.href='standard.html'">RECIPE</a>
            <a class="btn" style="
                text-decoration: none;
                margin-left:50px;
                color:black;
                cursor:pointer;"
            onCLick = "location.href='precipe.html'">OWN RECIPE</a>
            <a class="btn" style="
                text-decoration: none;
                margin-left:50px;
                color:black;
                cursor:pointer;"
            onclick="location.href='standardranking.jsp'">RANKING</a>
            <a class="btn" style="
                text-decoration: none;
                margin-left:50px;
                color:black;
                cursor:pointer;"
            onClick=location.href='profile.html'>PROFILE</a>
            <a class="btn" style="
                text-decoration: none;
                margin-left:50px;
                color:black;
                cursor:pointer;"
            onClick=location.href='logout.jsp'>LOGOUT</a>
        </div>
    </div>
    
            <table style="
                width: 70%;
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
                width: 70%;
                text-align: center;
                margin: auto;
                margin-top: 60px;
                font-size: 1.4rem;
            ">
    <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
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
      <td align="center" width="76">작성자</td>
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
     <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr><tr>
      <td align="center" width="76">재료</td>
      <td width="319"><%=ingre%></td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
     </table>
     <table style="
                width: 70%;
                margin: auto;
                font-size: 1.4rem;">          
                <tr>

                   <td width="399" colspan="1" height="200"><%=recipe %>
                </tr>
                <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
    </table>
    <table style="
                width: 70%;
                text-align: center;
                margin: auto;
                margin-top: 30px;
                font-size: 1.4rem;
            ">


<%
                query="UPDATE PRECIPE SET VIEW=" + view + " WHERE RNUM=" + rnum + ";";
                stmt.executeUpdate(query);
            }
    } catch(SQLException ex) {
        out.println(ex.getMessage());
        ex.printStackTrace();
    }
%>

     <tr align="center">
      <td colspan="2" width="399">
	<input type=button value="목록" onClick=location.href='precipech.jsp' style="
        border: 1px solid #505352;
        background-color: #505352;
        margin-right: auto;
        margin-left: auto;
        margin: 10px;
        width: 100px;
        height: 50px;
        color: white;
        cursor: pointer;
    ">
	<input type=button value="수정" onClick=location.href='precipe_list.jsp' style="
        border: 1px solid #505352;
        background-color: #505352;
        margin-right: auto;
        margin-left: auto;
        margin: 10px;
        width: 100px;
        height: 50px;
        color: white;
        cursor: pointer;
    ">
     </tr>
    </table>
<%
    try{
        // Driver로부터 데이터베이스와의 Connection을 얻기 위함
        String jdbcDriver ="jdbc:mysql://localhost:3306/TestDB?serverTimezone=UTC"; 
        String dbUser ="tester"; //mysql id
        String dbPass ="1234"; //mysql password
        String sqlCom = "SELECT CTIME, COMMENTS, ID FROM COMMENTS WHERE RNUM="+rnum+";";

        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

        // Connection 객체가 생성되면 SQL 문을 데이터베이스로 전송하기 위함
        stmt=conn.createStatement();
        

        rs = stmt.executeQuery(sqlCom);

%>
            <%-- 댓글란 및 댓글 저장 버튼 구현 --%>
            <table style="
                width:70%;
                text-align: center;
                margin: auto;
                margin-top: 60px;
                font-size: 1.4rem;
            ">

            <div style="height: 50px;">&nbsp;</div>
                <form action="/precipech3.jsp" method="post">
                <input type="hidden" name="rnum" value=<%=rnum%> />
                <textarea name="comments" style="
                    width: calc(100% - 1px);
                    height: 50px;
                    padding: 15px;
                    margin: auto;
                    box-sizing: border-box;
                    resize: vertical;
                    white-space: pre;
                    outline-color: black;
                "></textarea>
                <input type="submit" value="저장" style="
                    border: 1px solid #505352;
                    background-color: #505352;
                    margin-right: auto;
                    margin-left: auto;
                    margin: 10px;
                    width: 100px;
                    height: 50px;
                    color: white;
                    float: right;
                    cursor: pointer;
                ">
                </form>


<%
            // 댓글 목록
            while (rs.next()){
                String ctime = rs.getString("ctime");
                String comments = rs.getString("comments");
                String id = rs.getString("id");

%>
            <tr height="1" bgcolor="#D2D2D2"><td colspan="6"></td></tr>
            <tr height="25" align="center" >
	            <td align="center"><%=ctime %></td>
	            <td align="left"><%=comments %></td>
	            <td align="center"><%=id %></td>
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
%>

            </table>

    </body>
</html>