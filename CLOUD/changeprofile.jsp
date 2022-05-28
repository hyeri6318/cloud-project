<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import ="java.util.ArrayList" %>
<% request.setCharacterEncoding("utf-8"); %>

<html>
    <head>
        <title>CHANGE PASSWORD</title>
    </head>

    <body>
        <%
        String id=(String)session.getAttribute("id");

        String PPS=request.getParameter("pps");
        String NPS1=request.getParameter("nps1");
        String NPS2=request.getParameter("nps2");

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
            ArrayList<String> ps_list = new ArrayList<String>();
            
            // 2차원 테이블 형태의 결과 값에 대해 레코드 단위로 접근할 수 있도록 순회 함수 next 사용
            while(rs.next()){
                id_list.add(rs.getString("ID"));
                ps_list.add(rs.getString("PS"));
            }

            int ch=0; // 비밀번호 변경되었는지 확인하는 변수

            for(int i=0; i<ps_list.size();i++){
                if(id.equals(id_list.get(i)) && PPS.equals(ps_list.get(i))){
                    if(PPS.equals(NPS1)==false){
                        if(NPS1.equals(NPS2)){
                            String sql="UPDATE CLIENT SET PS = '"+NPS1+"' WHERE ID = '"+id+"'";
                            int count=stmt.executeUpdate(sql);
                            
                            ch=-1; // 비밀번호 성공했을 때 변수

                            response.sendRedirect("login.html");
                        }
                    } else{
                      out.println("<script>alert('변경 전과 동일한 비밀번호 입니다');</script>");
                      out.println("<script>history.go(-1);</script>");
                    }
                }
            }

            if(ch==0){
               out.println("<script>alert('비밀번호 변경 실패');</script>");
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