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
    SFR-101 : 로그인  페이지
              아이디, 비밀번호를  입력 받아 로그인할 수 있도록 구현
              이때, DB에 저장된 아이디와 비밀번호가 일치하는 경우 로그인 되도록 구현
 --%>

<html>
    <head>
        <title>세나요</title>
    </head>
    
    <body>
        <%
        String ID=request.getParameter("id"); 
        String PS=request.getParameter("ps");
        
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

            int lh=0; // 로그인이 되었는지 확인하는 변수
            
            // 데이터 베이스에 저장되어 있는 아이디와, 비밀번호가 사용자가 입력한 아이디, 비밀번호와 일치하는지 확인
            for(int i=0; i<id_list.size();i++){
                if(ID.equals(id_list.get(i)) && PS.equals(ps_list.get(i))){ 

                    session.setAttribute("id",ID);  // 일치하는 경우 ID를 세션값에 담음
                    session.setAttribute("ps",PS);  // 일치하는 경우 PS를 세션값에 담음

                    lh=-1; // 로그인 성공했을 때 변수

                    response.sendRedirect("main.jsp");  // 로그인 성공시 메인 페이지로 이동
                }
            }

            if(lh==0){
               out.println("<script>alert('로그인 실패');</script>");
               out.println("<script>history.go(-1);</script>");
            
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
    </body>
</html>