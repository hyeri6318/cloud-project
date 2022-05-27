<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import ="java.util.ArrayList" %>

<html>
    <head>
        <title>CHANGE PASSWORD</title>
    </head>

    <body>
        <%
        String id=(String)session.getAttribute("id");
        String ps =(String)session.getAttribute("ps");

        String PS=request.getParameter("ps");

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
           // ArrayList<String> ps_list = new ArrayList<String>();
            
            // 2차원 테이블 형태의 결과 값에 대해 레코드 단위로 접근할 수 있도록 순회 함수 next 사용
            while(rs.next()){
                id_list.add(rs.getString("ID"));
              //  ps_list.add(rs.getString("PS"));
            }

            int dh=0; // 회원 삭제 되었는지 확인하는 변수

            for(int i=0; i<id_list.size();i++){
                if(id.equals(id_list.get(i)) && PS.equals(ps)){
                    String sql="DELETE FROM CLIENT WHERE ID = '"+id+"'";
                    int count=stmt.executeUpdate(sql);

                    dh=-1;

                    response.sendRedirect("index.html");

                    
                }
            }

            if(dh==0){
               out.println("<script>alert('회원 탈퇴 실패');</script>");
               out.println("<script>history.go(-1);</script>");
            }

        }catch(SQLException ex) {
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