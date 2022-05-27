<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="java.lang.String" %>
<html>
    <head>
        <title>세나요</title>
    </head>

    <body>
        <%
        String id=(String)session.getAttribute("id");

        String TITLE = request.getParameter("title");
        String TIME = request.getParameter("time");
        String WEATHER = request.getParameter("weather");
        String INGRE = request.getParameter("ingre");
        String RECIPE = request.getParameter("recipe");
        
        // 업로드할 클래스 이름 지정
        Class.forName("com.mysql.cj.jdbc.Driver"); 
        Connection conn =null;
        Statement stmt =null;
        ResultSet rs =null;

        try{
            // Driver로부터 데이터베이스와의 Connection을 얻기 위함
            String jdbcDriver ="jdbc:mysql://localhost:3306/TestDB?serverTimezone=UTC"; 
            String dbUser ="tester"; //mysql id
            String dbPass ="1234"; //mysql password
            String query ="select * from CLIENT"; //query
        
            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

            // Connection 객체가 생성되면 SQL 문을 데이터베이스로 전송하기 위함
            stmt=conn.createStatement();

            // user 테이블로부터 사용자 아이디와 패스워드 정보 추출
            rs = stmt.executeQuery(query);

            ArrayList<String> id_list = new ArrayList<String>();

           while(rs.next()){
                id_list.add(rs.getString("ID"));
            }

            for(int i=0; i<id_list.size();i++){
                if(id.equals(id_list.get(i))){
                    String sql1="UPDATE CLIENT SET POINT=POINT+3 WHERE ID = '"+id+"'";
                    int count1=stmt.executeUpdate(sql1);
                }
            }

            String sql2="insert into PRERECIPE(WEATHER,TITLE,ID,TIME,RECIPE) values";
            sql2+="('"+WEATHER+"','"+TITLE+"','"+id+"','"+TIME+"','"+RECIPE+"')";
            int count2 = stmt.executeUpdate(sql2);
            
            String sql3="insert into PINGRE(INGRE) values";
            sql3+="('"+INGRE+"')";
            int count3 = stmt.executeUpdate(sql3);


            // 가장 마지막 RNUM 읽는 쿼리
            // String sql3="select RNUM from PRERECIPE order by RNUM desc limit 1";
            // out.print(sql3);
            

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
    </body>
</html>