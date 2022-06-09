<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="java.lang.String" %>
<% request.setCharacterEncoding("utf-8"); %>

<%-- 
    담당자 : 이혜리
    SFR-300 ~ SFR-302 : 제목, 시간, 카테고리, 날씨, 재료, 레시피를 작성할 수 있도록 구현한다.
                        저장 버튼을 누르면 작성한 사용자에게 3포인트를 지급하도록 구현한다.
 --%>

<html>
    <head>
        <title>세나요</title>
    </head>

    <body>
        <%
        String id=(String)session.getAttribute("id");

        String TITLE = request.getParameter("title");
        String TIME = request.getParameter("time");
        String CATE = request.getParameter("cate");
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
            String jdbcDriver ="jdbc:mysql://localhost:3306/ProjectDB?serverTimezone=UTC"; 
            String dbUser ="cloud"; //mysql id
            String dbPass ="5678"; //mysql password
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
                if(id.equals(id_list.get(i))){  // 세션값에 담긴 아이디와 CLIENT 데이터베이스에 저장된 아이디 값이 일치하는지 확인
                    String sql1="UPDATE CLIENT SET POINT=POINT+3 WHERE ID = '"+id+"'";  // 해당 아이디를 가진 사용자가에 3포인트를 추가로 지급
                    int count1=stmt.executeUpdate(sql1);
                }
            }

            String sql2="insert into PRECIPE(WEATHER,CATE,TITLE,ID,TIME,RECIPE,INGRE) values";  // 사용자가 입력한 개인레시피를 PRECIPE 데이터베이스에 저장
            sql2+="('"+WEATHER+"','"+CATE+"','"+TITLE+"','"+id+"','"+TIME+"','"+RECIPE+"','"+INGRE+"')";
            int count2 = stmt.executeUpdate(sql2);

             response.sendRedirect("precipe.html");
        
            
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