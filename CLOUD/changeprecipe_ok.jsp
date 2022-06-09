<%-- 
    담당자 : 이혜리
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
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%-- 
    담당자 : 이혜리
    SFR-303 : 정보변경 버튼을 누르면 실행이되도록 구현한다.
 --%>

<html>
    <head>
        <title>세나요</title>
    </head>

    <body>

<%      
        int rnum = Integer.parseInt(request.getParameter("rnum"));
        String id=(String)session.getAttribute("id");
        String title = request.getParameter("title");
        String time = request.getParameter("time");
        String ingre = request.getParameter("ingre");
        String recipe= request.getParameter("recipe");
        
       String cate = request.getParameter("cate");

       String weather = request.getParameter("weather");

        Class.forName("com.mysql.cj.jdbc.Driver"); 
        Connection conn =null;
        Statement stmt =null;
        ResultSet rs =null;

        

    try{
        // Driver로부터 데이터베이스와의 Connection을 얻기 위함
        String jdbcDriver ="jdbc:mysql://localhost:3306/ProjectDB?serverTimezone=UTC"; 
        String dbUser ="cloud"; //mysql id
        String dbPass ="5678"; //mysql password
        String query ="SELECT * FROM PRECIPE WHERE RNUM=" + rnum + ";";

        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

        // Connection 객체가 생성되면 SQL 문을 데이터베이스로 전송하기 위함
        stmt=conn.createStatement();
        
        // user 테이블로부터 사용자 아이디와 패스워드 정보 추출
        rs = stmt.executeQuery(query);
        

            ArrayList<String> id_list = new ArrayList<String>();

            while(rs.next()){
                id_list.add(rs.getString("ID"));
            }

            // 개인레시피 번호, 조회수를 제외한 날씨, 카테고리, 제목, 소요시간, 레시피, 재료를 변경
            String sql1="UPDATE PRECIPE SET WEATHER = '"+weather+"',CATE = '"+cate+"', TITLE = '"+title+"' , TIME= '"+time+"',RECIPE='"+recipe+"', INGRE= '"+ingre+"' WHERE RNUM=" + rnum + ";";
            int count1 = stmt.executeUpdate(sql1);

            response.sendRedirect("precipe_list.jsp");  // 정보를 변경한 후 사용자가 작성한 개인레시피 목록 리스트 페이지로 넘어간다.

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