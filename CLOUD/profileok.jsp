<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="java.io.PrintWriter" %>
<% request.setCharacterEncoding("utf-8"); %>

<%-- 
    담당자 : 이혜리
    SFR-200 ~ SFR-203 : 정보 변경 버튼을 누르면 실행되는 jsp
 --%>

<%
String pw=(String)session.getAttribute("ps");

String ID=request.getParameter("ID");
String PW = request.getParameter("PW");
String NPW1=request.getParameter("NPW1");
String NPW2=request.getParameter("NPW2");

Class.forName("com.mysql.cj.jdbc.Driver"); 
  Connection conn =null;
  Statement stmt =null;
  ResultSet rs =null;

  try{
      // Driver로부터 데이터베이스와의 Connection을 얻기 위함
      String jdbcDriver ="jdbc:mysql://localhost:3306/ProjectDB?serverTimezone=UTC"; 
      String dbUser ="cloud"; //mysql id
      String dbPass ="5678"; //mysql password
      String query ="select * from CLIENT WHERE ID='"+ID+"'"; //query
        
      conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

      // Connection 객체가 생성되면 SQL 문을 데이터베이스로 전송하기 위함
      stmt=conn.createStatement();

      // user 테이블로부터 사용자 아이디와 패스워드 정보 추출
       rs = stmt.executeQuery(query);

      if(rs.next()){
          ID=rs.getString(1);
      }

      if(PW.equals(pw)){  // 세션에 담은 비밀번호와 사용자가 입력한 기존 비밀번호가 일치하는지 확인
        if(NPW1.equals(NPW2)){  // 변경할 비밀번호와 체크 비밀번호가 일치하는지 확인
          String sql1="UPDATE CLIENT SET PS = '"+NPW1+"' WHERE ID = '"+ID+"'";  // 일치하는 경우 CLIENT 데이터베이스에 변경된 비밀번호를 업데이트
          stmt.executeUpdate(sql1);

          out.println("<script>alert('정보 변경 완료');</script>");
          response.sendRedirect("login.html");  // 정보 변경이 성공하면 로그인 페이지로 이동
        } else{
          out.println("<script>alert('정보 변경 실패');</script>");
          out.println("<script>history.go(-1);</script>");
        }
      }else{
        out.println("<script>alert('정보 변경 실패');</script>");
        out.println("<script>history.go(-1);</script>");
      }

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