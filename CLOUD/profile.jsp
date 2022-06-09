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
    SFR-200 ~ SFR-203: 프로필 출력 및 개인 정보 변경 구현
              로그인한 아이디와 일치하는 사용자 정보를 데이터베이스에서 가져와 출력하도록 구현
              이름, 아이디, 포인트는 변경이 불가능하게 하고 비밀번호만 변경이 가능하도록 구현
 --%>

  <html>
  <head>
    <link href="style.css" rel="stylesheet">
    <title>게시판</title>
  </head>

  <%
  String id=(String)session.getAttribute("id");

  String NAME="";
  String ID="";
  String PW="";
  String NPW1="";
  String NPW2="";
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
        PW=rs.getString(3);
        NAME=rs.getString(4);
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
        "><a style="float: left;" onCLick = "location.href='main.jsp'">
            세상에 나쁜 요리는 없다</a>
        </h3>
    </div>
    <table style="
      width: 80%;
      text-align: center;
      margin: auto;
      margin-top: 30px;
      font-size: 1.4rem;
    ">
      <tr>
        <td>
          <table >
            <tr>
              <h1 style="
                    margin-top: 30px;
                    margin-left: 30px;
                    color: black;
                    text-align: center;
                ">
                    PROFILE</h1>
            </tr>
        </td>
      </tr>
    </table>
<form action="profileok.jsp" method="post">
    <table style="
        text-align: center;
        margin: auto;
        margin-top: 30px;
        font-size: 1.4rem;
    ">
      
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
          <input type=submit value="회원 정보 수정" style="
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
          <input type=button value="탈퇴"  onClick="location.href='deleteprofile.html'" style="
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

         <input type=button value="개인 레시피 조회"  onClick="location.href='precipe_list.jsp'" style="
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
          <input type=button value="취소" onClick="location.href='main.jsp'" style="
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
        <td>&nbsp;</td>
      </tr>
    </table>
    </td>
    </tr>
    </table>
    </form>
  </body>
   

  </html>