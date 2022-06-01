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
// 1. getParameter(url)을 통해 url 들고 오기 => pk값 num으로
String cloumnnum = request.getParameter("num");

Class.forName("com.mysql.cj.jdbc.Driver"); 
Connection conn =null;
Statement stmt =null;
ResultSet rs =null;
//try {
    // 2. DB에서 url을 찾아 그 행의 count를 1 증가
    String jdbcDriver ="jdbc:mysql://localhost:3306/TestDB?serverTimezone=UTC"; 
    String dbUser ="tester"; //mysql id
    String dbPass ="1234"; //mysql password
    String query ="select * from recipe where num='" + cloumnnum + "';"; //query
    // Create DB Connection
    conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
    // Create Statement
    stmt = conn.createStatement();
    // Run Qeury
    rs = stmt.executeQuery(query);
    // Print Result (Run by Query)

    rs.next();
    int views = rs.getInt("views") + 1;
    String url = rs.getString("link");

    String updateViewsQuery = "update recipe set views=" + views + " where num='" + cloumnnum + "';";
    stmt.executeUpdate(updateViewsQuery);
//} catch(SQLException e) {
//    
//}
// 3. url으로 이동 시키기(JSP redirect)
response.sendRedirect(url);
%>

