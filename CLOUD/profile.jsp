<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="java.io.PrintWriter" %>
<% request.setCharacterEncoding("utf-8"); %>

  <html>

  <head>
    <title>세나요</title>
  </head>

  <%
  String id=(String)session.getAttribute("id");

  String NAME="";
  String ID="";
  String PW="";
  String NPW1="";
  String NPW2="";
  String LIVE="";
  String POINT="";
//  int indx = Integer.parseInt(requset.getParameter("idx"));

  Class.forName("com.mysql.cj.jdbc.Driver"); 
  Connection conn =null;
  Statement stmt =null;
  ResultSet rs =null;

  try{
      // Driver로부터 데이터베이스와의 Connection을 얻기 위함
      String jdbcDriver ="jdbc:mysql://localhost:3306/ProjectDB?serverTimezone=UTC"; 
      String dbUser ="cloud"; //mysql id
      String dbPass ="5678"; //mysql password
      String query ="select * from CLIENT WHERE ID = '"+id+"'"; //query
        
      conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

      // Connection 객체가 생성되면 SQL 문을 데이터베이스로 전송하기 위함
      stmt=conn.createStatement();

      // user 테이블로부터 사용자 아이디와 패스워드 정보 추출
       rs = stmt.executeQuery(query);

      if(rs.next()){
        ID=rs.getString(1);
        POINT=rs.getString(2);
        LIVE=rs.getString(3);
        PW=rs.getString(4);
        NAME=rs.getString(5);
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

  <body>
    <table>
      <tr>
        <td>
          <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
              <td>PROFILE</td>
            </tr>
        </td>
      </tr>
    </table>
<form action="profileok.jsp" method="post">
    <table>
      
      <tr>
        <td>&nbsp;</td>
        <td align="center">이름</td>
        <td><%=NAME%><input type=hidden name="NAME" size="50" value="<%=NAME%>"></td>
        <td>&nbsp;</td>
      </tr>
      <tr height="1" bgcolor="#dddddd">
        <td colspan="4"></td>
      </tr>

      <tr>
        <td>&nbsp;</td>
        <td align="center">아이디</td>
        <td><%=ID%><input type=hidden name="ID" size="50" value="<%=ID%>"></td>
        <td>&nbsp;</td>
      </tr>
      <tr height="1" bgcolor="#dddddd">
        <td colspan="4"></td>
      </tr>

      <tr>
        <td>&nbsp;</td>
        <td align="center">현재 비밀번호</td>
        <td><input type=password name="PW" size="50" maxlength="50"></td>
        <td>&nbsp;</td>
      </tr>
      <tr height="1" bgcolor="#dddddd">
        <td colspan="4"></td>
      </tr>

      <tr>
        <td>&nbsp;</td>
        <td align="center">변경할 비밀번호</td>
        <td><input type=password name="NPW1" size="50" maxlength="50"></td>
        <td>&nbsp;</td>
      </tr>
      <tr height="1" bgcolor="#dddddd">
        <td colspan="4"></td>
      </tr>

      <tr>
        <td>&nbsp;</td>
        <td align="center">변경 확인 비밀번호</td>
        <td><input type=password name="NPW2" size="50" maxlength="50"></td>
        <td>&nbsp;</td>
      </tr>
      <tr height="1" bgcolor="#dddddd">
        <td colspan="4"></td>
      </tr>

      <tr>
        <td>&nbsp;</td>
        <td align="center">사는곳</td>
        <td><input type=text name="LIVE" size="50" maxlength="50" value="<%=LIVE%>"></td>
        <td>&nbsp;</td>
      </tr>
      <tr height="1" bgcolor="#dddddd">
        <td colspan="4"></td>
      </tr>

      <tr>
        <td>&nbsp;</td>
        <td align="center">포인트</td>
        <td><%=POINT%><input type=hidden name="POINT" size="50" maxlength="50" value="<%=POINT%>"></td>
        <td>&nbsp;</td>
      </tr>
      <tr height="1" bgcolor="#dddddd">
        <td colspan="4"></td>
      </tr>
      
      <tr align="center">
        <td>&nbsp;</td>
        <td colspan="2">
          <input type=submit value="회원 정보 수정">
          <input type=button value="탈퇴"  onClick="location.href='deleteprofile.html'"> 
          <input type=button value="취소" onClick="location.href='main.html'" >
        <td>&nbsp;</td>
      </tr>
    </table>
    </td>
    </tr>
    </table>
    </form>
  </body>
   

  </html>