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

  String RNUM="";
  String TITLE="";
  String TIME="";
  String INGRE="";
  String RECIPE="";
  String WEATHER="";
  String CATE="";
  //String KOREA="";
  //String CHINESE="";
  //String WESTERN="";
  //String JAPANESE="";
  //String SUNNY="";
  //String CLOUD="";
  //String RAIN="";
  //String SNOW="";
  //String FOG="";
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
      String query ="select * from PRECIPE WHERE ID = '"+id+"'"; //query
        
      conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

      // Connection 객체가 생성되면 SQL 문을 데이터베이스로 전송하기 위함
      stmt=conn.createStatement();

      // user 테이블로부터 사용자 아이디와 패스워드 정보 추출
       rs = stmt.executeQuery(query);

       // out.print(RECIPE.replace("\r\n","<br>"));

      if(rs.next()){
        RNUM=rs.getString(1);
        WEATHER=rs.getString(2);
        CATE=rs.getString(3);
        TITLE=rs.getString(4);
        TIME=rs.getString(7);
        RECIPE=rs.getString(8);
        INGRE=rs.getString(9);
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
              <td>RECIPE</td>
            </tr>
        </td>
      </tr>
    </table>
<form action="changeprecipe_ok.jsp" method="post">
    <table>
      <tr>
        <td>&nbsp;</td>
        <td align="center">레시피 번호</td>
        <td><%=RNUM%><input type=hidden name="RNUM" size="50" value="<%=RNUM%>"></td>
        <td>&nbsp;</td>
      </tr>
      <tr height="1" bgcolor="#dddddd">
        <td colspan="4"></td>
      </tr>
      
      <tr>
        <td>&nbsp;</td>
        <td align="center">제목</td>
        <td><input type=text name="TITLE" size="50" value="<%=TITLE%>"></td>
        <td>&nbsp;</td>
      </tr>
      <tr height="1" bgcolor="#dddddd">
        <td colspan="4"></td>
      </tr>

      <tr>
        <td>&nbsp;</td>
        <td align="center">소요시간 (분)</td>
        <td><input type=text name="TIME" size="50" value="<%=TIME%>"></td>
        <td>&nbsp;</td>
      </tr>
      <tr height="1" bgcolor="#dddddd">
        <td colspan="4"></td>
      </tr>

      <tr>
        <td>&nbsp;</td>
        <td align="center">카테고리</td>
        <td>
        <input type="radio" name="CATE" value="<%=CATE%>"> 한식
        <input type="radio" name="CATE" value="<%=CATE%>"> 중식
        <input type="radio" name="CATE" value="<%=CATE%>"> 양식
        <input type="radio" name="CATE" value="<%=CATE%>"> 일식
        </td>
        <td>&nbsp;</td>
      </tr>
      <tr height="1" bgcolor="#dddddd">
        <td colspan="4"></td>
      </tr>

      <tr>
        <td>&nbsp;</td>
        <td align="center">날씨</td>
        <td>
        <input type="radio" name="WEATHER" value="<%=WEATHER%>"> 맑음
        <input type="radio" name="WEATHER" value="<%=WEATHER%>"> 흐림
        <input type="radio" name="WEATHER" value="<%=WEATHER%>"> 비
        <input type="radio" name="WEATHER" value="<%=WEATHER%>"> 눈
        <input type="radio" name="WEATHER" value = "<%=WEATHER%>"> 안개
        </td>
        <td>&nbsp;</td>
      </tr>
      <tr height="1" bgcolor="#dddddd">
        <td colspan="4"></td>
      </tr>

      <tr>
        <td>&nbsp;</td>
        <td align="center">재료</td>
        <td><input type=text name="INGRE" size="50" maxlength="50" value="<%=INGRE%>"></td>
        <td>&nbsp;</td>
      </tr>
      <tr height="1" bgcolor="#dddddd">
        <td colspan="4"></td>
      </tr>

      <tr>
        <td>&nbsp;</td>
        <td><input type=textarea name="RECIPE" value="<%=RECIPE.replace("\r\n","<br>")%>"></textarea></td>
        <td>&nbsp;</td>
      </tr>
      <tr height="1" bgcolor="#dddddd">
        <td colspan="4"></td>
      </tr>
      
      <tr align="center">
        <td>&nbsp;</td>
        <td colspan="2">
          <input type=submit value="레시피 수정"> 
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