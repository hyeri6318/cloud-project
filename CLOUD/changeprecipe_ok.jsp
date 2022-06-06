<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="java.io.PrintWriter" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
String id=(String)session.getAttribute("id");

String TITLE=request.getParameter("TITLE");
String TIME=request.getParameter("TIME");
String INGRE=request.getParameter("INGRE");
String RECIPE=request.getParameter("RECIPE");
String WEATHER=request.getParameter("WEATHER");
String CATE=request.getParameter("CATE");

Class.forName("com.mysql.cj.jdbc.Driver"); 
  Connection conn =null;
  Statement stmt =null;
  ResultSet rs =null;

  try{
      // Driver로부터 데이터베이스와의 Connection을 얻기 위함
      String jdbcDriver ="jdbc:mysql://localhost:3306/ProjectDB?serverTimezone=UTC"; 
      String dbUser ="cloud"; //mysql id
      String dbPass ="5678"; //mysql password

      // 추후 아이디 혹은 RNUM으로 쿼리 수정 필요
      String query ="select * from PRECIPE WHERE ID='"+id+"'"; //query
        
      conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

      // Connection 객체가 생성되면 SQL 문을 데이터베이스로 전송하기 위함
      stmt=conn.createStatement();

      // user 테이블로부터 사용자 아이디와 패스워드 정보 추출
       rs = stmt.executeQuery(query);

      if(rs.next()){
         // RNUM=rs.getString(1);
         // ID=rs.getString(6);
      }
      
      
      String sql1="UPDATE PRECIPE SET WEATHER = '"+WEATHER+"' ,CATE = '"+CATE+"', TITLE = '"+TITLE+"', TIME = '"+TIME+"', RECIPE = '"+RECIPE+"', INGRE = '"+INGRE+"' WHERE ID = '"+id+"'";
      stmt.executeUpdate(sql1);
      
      out.println("<script>alert('정보 변경 완료');</script>");
     // response.sendRedirect("login.html");
    

  } catch(SQLException ex) {
    out.println(ex.getMessage());
    ex.printStackTrace();
  } finally {
    // Close Statement
    if (rs !=null) try { rs.close(); } catch(SQLException ex) {}
    if (stmt !=null) try { stmt.close(); } catch(SQLException ex) {}
    // Close Connection
    if (conn !=null) try { conn.close(); } catch(SQLException ex) {}
}
%>