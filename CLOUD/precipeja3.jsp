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
        String id=(String)session.getAttribute("id");
        //int rnum = Integer.parseInt(request.getParameter("rnum"));
        String rnum = request.getParameter("rnum");
        String comments = request.getParameter("comments");
        Class.forName("com.mysql.cj.jdbc.Driver"); 
        Connection conn =null;
        Statement stmt =null;
        ResultSet rs =null;

        

    try{
        // Driver로부터 데이터베이스와의 Connection을 얻기 위함
        String jdbcDriver ="jdbc:mysql://localhost:3306/ProjectDB?serverTimezone=UTC"; 
        String dbUser ="cloud"; //mysql id
        String dbPass ="5678"; //mysql password
        String sqlCom = "select * from CLIENT";

        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

        // Connection 객체가 생성되면 SQL 문을 데이터베이스로 전송하기 위함
        stmt=conn.createStatement();
        
        // user 테이블로부터 사용자 아이디와 패스워드 정보 추출
        rs = stmt.executeQuery(sqlCom);
        

            ArrayList<String> id_list = new ArrayList<String>();

            while(rs.next()){
                id_list.add(rs.getString("ID"));
            }

            for(int i=0; i<id_list.size(); i++){
                if(id.equals(id_list.get(i))){
                    String sql="insert into COMMENTS(CTIME, COMMENTS, ID, RNUM) values";
                    sql+="(now(),'"+comments+"','"+id+"',"+rnum+");";
                    int count4 = stmt.executeUpdate(sql);
                }
            }
        response.sendRedirect("/precipeja.jsp");
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