<!--장영훈-->
<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>

<%
//http://49.50.164.44/redirectHandler.jsp?url=https://www.10000recipe.com/recipe/6898328
// 1. getParameter(num)을 통해 url 들고 오기 => pk값 num으로
String cloumnnum = request.getParameter("num");

Class.forName("com.mysql.cj.jdbc.Driver"); 
Connection conn =null;
Statement stmt =null;
ResultSet rs =null;
//try {
    // 2. DB에서 url을 찾아 그 행의 count를 1 증가
    String jdbcDriver ="jdbc:mysql://localhost:3306/ProjectDB?serverTimezone=UTC"; 
    String dbUser ="cloud"; //mysql id
    String dbPass ="5678"; //mysql password
    String query ="select * from recipe where num='" + cloumnnum + "';"; // query문을 통해 num값이 columnnum과 같은걸 가져온다
    // Create DB Connection
    conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
    // Create Statement
    stmt = conn.createStatement();
    // Run Qeury
    rs = stmt.executeQuery(query);
    // Print Result (Run by Query)
    
    // DB에 저장된 views 값을 1 증가, url에 db에 저장된 link값을 넣는다
    rs.next();
    int views = rs.getInt("views") + 1;
    String url = rs.getString("link");

    // 조회수 올라간걸 DB에 업데이트 시킨다
    String updateViewsQuery = "update recipe set views=" + views + " where num='" + cloumnnum + "';";
    stmt.executeUpdate(updateViewsQuery);

    // 3. url으로 이동 시키기(JSP redirect)
    response.sendRedirect(url);
%>
