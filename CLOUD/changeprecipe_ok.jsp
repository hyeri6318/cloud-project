[changeprecipe_ok.jsp]
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

<html>
    <head>
        <title>세나요</title>
    </head>

    <body>

<%      
        int rnum = Integer.parseInt(request.getParameter("rnum"));
        //String rnum = request.getParameter("rnum");
        String id=(String)session.getAttribute("id");
        String title = request.getParameter("title");
        String time = request.getParameter("time");
        //int view = request.getInt("view");
        String ingre = request.getParameter("ingre");
        String recipe= request.getParameter("recipe");

        String korea = request.getParameter("korea");
        String chinese = request.getParameter("chinese");
        String japanese = request.getParameter("japanese");
        String wetsern = request.getParameter("western");

        //String weather = request.getParameter("sunny");
        //String weather = request.getParameter("cloud");
        //String weather = request.getParameter("fog");
        //String weather = request.getParameter("rain");
       // String weather = request.getParameter("snow");

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

            String sql1="UPDATE PRECIPE SET WEATHER = '"+weather+"', TITLE = '"+title+"' , TIME= '"+time+"',RECIPE='"+recipe+"', INGRE= '"+ingre+"' WHERE RNUM=" + rnum + ";";
            int count1 = stmt.executeUpdate(sql1);

            response.sendRedirect("precipe_list.jsp");

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