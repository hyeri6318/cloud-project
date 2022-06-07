<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="java.lang.String" %>
<% request.setCharacterEncoding("utf-8"); %>

<html>
    <head>
    <link href="style.css" rel="stylesheet">
    <title>중식</title>
    </head>
    <body style="background:rgb(77, 76, 76);">

    <div class="head" style="
        position: sticky;
        top: 0;
        left: 0;
        right: 0;
        background-color: rgba(0, 0, 0, 0.2);
        backdrop-filter: blur(6px);
        padding: 0.8rem;
        display: flex;
        justify-content: space-between;
    ">
        <h3 style="margin: 0;
            font-size: 2.5rem;
            color: white;
        ">
            세상에 나쁜 요리는 없다
        </h3>
        <div class="menu" style="
            padding: 0;
            margin: 0;
            list-style: none;
            font-size: 1.5rem;
        ">
            <a class="btn" style="
                text-decoration: none;
                margin-left:50px;
                color:white;
                cursor:pointer;
            ">RECIPE</a>
            <a class="btn" style="
                text-decoration: none;
                margin-left:50px;
                color:white;
                cursor:pointer;
            ">OWN RECIPE</a>
            <a class="btn" style="
                text-decoration: none;
                margin-left:50px;
                color:white;
                cursor:pointer;
            ">RANKING</a>
            <a class="btn" style="
                text-decoration: none;
                margin-left:50px;
                color:white;
                cursor:pointer;"
            onClick=location.href='profile.html'>PROFILE</a>
        </div>
    </div>

    <%
        // 업로드할 클래스 이름 지정
        Class.forName("com.mysql.cj.jdbc.Driver"); 
        Connection conn =null;
        Statement stmt =null;
        ResultSet rs =null;
        int total = 0; 
        try{
            // Driver로부터 데이터베이스와의 Connection을 얻기 위함
            String jdbcDriver ="jdbc:mysql://localhost:3306/TestDB?serverTimezone=UTC"; 
            String dbUser ="tester"; //mysql id
            String dbPass ="1234"; //mysql password
            String query ="select RNUM, TITLE, ID, TIME, VIEW from PRECIPE where CATE='chinese' order by VIEW DESC"; //query
        
            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

            // Connection 객체가 생성되면 SQL 문을 데이터베이스로 전송하기 위함
            stmt=conn.createStatement();

            //if(rs.next()){
            //    total = rs.getInt(1);
            //}

            // user 테이블로부터 사용자 아이디와 패스워드 정보 추출
            rs = stmt.executeQuery(query);


            // TODO
    %>

            <h1 style="
                    margin-top: 60px;
                    margin-bottom: 60px;
                    margin-left: 30px;
                    color: white;
                ">
                    CHINESE FOODS</h1>

            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr><td colspan="4" height="5"></td></tr>
                <tr align="center">
                    <td><input type=button value="글쓰기" style="
                    border: 1px solid #505352;
                    background-color: #505352;
                    margin-left: 72%;
                    width: 100px;
                    height: 50px;
                    color: white;
                    cursor: pointer;
                " onClick=location.href='precipeuproad.html'></td>
                </tr>
                
            </table>

            <table style="
                width: 80%;
                text-align: center;
                margin: auto;
                margin-top: 30px;
                font-size: 1.4rem;
            ">
            <tr height="1" bgcolor="#D2D2D2"><td colspan="6"></td></tr>
            <tr height="1"><td width="5"></td></tr>
            <td width="10%">번호</td>
            <td width="60%">제목</td>
            <td width="10%">작성자</td>
            <td width="10%">소요시간</td>
            <td width="10%">조회수</td>
            <tr height="1" bgcolor="#D2D2D2"><td colspan="6"></td></tr>

    <%
            if(total!=0){
    %>
            <tr align="center" bgcolor="#FFFFFF" height="30">
	 	    <td colspan="6">등록된 글이 없습니다.</td>
	 	    </tr>
    <%
            }else{
                while(rs.next()){
                    int rnum = rs.getInt("rnum");
                    String title = rs.getString("title");
                    String id = rs.getString("id");
                    String time = rs.getString("time");
                    int view = rs.getInt("view");
    %>
                    <tr height="25" align="center" >
	                    
	                    <td><%=rnum %></td>
	                    <td align="left"><a href="precipech2.jsp?rnum=<%=rnum %>"><%=title %></td>
	                    <td align="center"><%=id %></td>
	                    <td align="center"><%=time %></td>
	                    <td align="center"><%=view %></td>
	                    <td>&nbsp;</td>
                    </tr>
                    <tr height="1" bgcolor="#D2D2D2"><td colspan="6"></td></tr>
    <%
                }
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch(SQLException ex) {
            out.println(ex.getMessage());
            ex.printStackTrace();
        }
    %>
                
            </table>
    </body>
</html>