<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import ="java.util.ArrayList" %>

<html>
    <head>
        <title>SIGN UP</title>
    </head>

    <body>
        <%
        String NID=request.getParameter("nid");
        String LIVE=request.getParameter("live");
        String NPS=request.getParameter("nps");
        String CPS=request.getParameter("cps");
        String NAME=request.getParameter("name");

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
            ArrayList<String> ps_list = new ArrayList<String>();
            
            // 2차원 테이블 형태의 결과 값에 대해 레코드 단위로 접근할 수 있도록 순회 함수 next 사용
            while(rs.next()){
                id_list.add(rs.getString("ID"));
                ps_list.add(rs.getString("PS"));
            }
            
            int sh=0;

            for(int i=0; i<id_list.size();i++){
                if(NID.equals(id_list.get(i))){
                    sh=-1;

                    out.println("<script>alert('이미 존재하는 아이디 입니다');</script>");
                    out.println("<script>history.go(-1);</script>");
                }

                if(NID.equals(id_list.get(i)) && NPS.equals(ps_list.get(i))){
                    sh=-1;// 이미 회원가입이 되어 있을 때의 변수

                    out.println("<script>alert('이미 가입되었습니다');</script>");
                    out.println("<script>history.go(-1);</script>");
                }
            }

            if(sh==0){
                if(NPS.equals(CPS)){
                String sql="insert into CLIENT(ID,POINT,LIVE,PS,NAME) values";
                sql +="('"+NID+"','5','"+LIVE+"','"+NPS+"','"+NAME+"')";
                int count = stmt.executeUpdate(sql);

                response.sendRedirect("login.html");
                } else{
                    out.println("<script>alert('비밀번호 불일치');</script>");
                    out.println("<script>history.go(-1);</script>");
                }
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