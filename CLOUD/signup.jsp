<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import ="java.util.ArrayList" %>
<% request.setCharacterEncoding("utf-8"); %>
<%-- 
    담당자 : 이혜리
    SFR-101 : 회원가입  페이지
              아이디, 이름, 비밀번호를  입력 받고 비밀번호 체크를 통해 회원가입을 할 수 있도록 구현
              이때, DB에 저장된 아이디와 동일한 아이디를 입력한 경우 회원가입이 불가능하게 구현
 --%>

<html>
    <head>
        <title>SIGN UP</title>
    </head>

    <body>
        <%
        String NID=request.getParameter("nid"); // 아이디
        String NPS=request.getParameter("nps"); // 비밀번호
        String CPS=request.getParameter("cps"); // 체크용 비밀번호
        String NAME=request.getParameter("name"); // 이름

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
            
            int sh=0;   // 같은 아이디가 존재하는지 확인하기 위한 변수

            for(int i=0; i<id_list.size();i++){
                if(NID.equals(id_list.get(i))){ // DB에 저장된 아이디와 사용자가 입력한 아이디가 같은지 확인
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
                if(NPS.equals(CPS)){    // 사용자가 원하는 비밀번호와 체크용 비밀번호가 일치하는지 확인
                String sql="insert into CLIENT(ID,POINT,PS,NAME) values"; // 일치하면 CLIENT 데이터베이스에 아이디, 포인트, 비밀번호, 이름을 저장
                sql +="('"+NID+"','5','"+NPS+"','"+NAME+"')";   // 회원가입시 5포인트를 자동으로 지급
                int count = stmt.executeUpdate(sql);

                response.sendRedirect("login.html");    // 회원가입 후 로그인 페이지로 이동해 로그인이 가능하게 함
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