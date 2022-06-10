<!--담당자 : 장영훈-->
<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>


<!DOCTYPE html>
<html lang="ko">
    <head>
        <title>표준 양식 레시피</title>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="standard.css">
    </head>
    <body>
        <% // MySQL JDBC Driver Loading
                Class.forName("com.mysql.cj.jdbc.Driver"); 
                Connection conn =null;
                Statement stmt =null;
                ResultSet rs =null;

                try {
                    String jdbcDriver ="jdbc:mysql://localhost:3306/ProjectDB?serverTimezone=UTC"; 
                    String dbUser ="cloud"; //mysql id
                    String dbPass ="5678"; //mysql password
                    String query ="select * from recipe where category='양식' ORDER BY views desc"; //query
                    // Create DB Connection
                    conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
                    // Create Statement
                    stmt = conn.createStatement();
                    // Run Qeury
                    rs = stmt.executeQuery(query);
                    // Print Result (Run by Query)
                   
            %>

            


<div class="head">
                <h3 style="
                    margin: 0;
                    font-size: 2.5rem;
                    color: black;
                    cursor: pointer;
                "><a style="float: left;" onCLick = "location.href='index.html'">세상에 나쁜 요리는 없다 </a>
                </h3>
                <div class="menu">
                    <a class="btn" onCLick = "location.href='standard.html'">RECIPE</a>
                    <a class="btn" onClick ="location.href='precipe.html'">OWN RECIPE</a>
                    <a class="btn" onclick="location.href='standardranking.jsp'">RANKING</a>
                    <a class="btn" onClick="location.href='login.html'">LOGIN</a>
                </div>
            </div>

        <div class="intro_text">
            <h1>WESTERN FOODS</h1>
        </div>


        <div class="recipe">
            <table>  
            
                <tr>
                    <%
            		int count = 1;
		            while (rs.next()) {
                    %>
				<td>
					<a href=<%="http://49.50.161.25:8080/redirectHandler.jsp?num=" + rs.getString("num")%>>
                    <img src='<%=rs.getString("picture")%>' width='300' height='300'><br>
                    <%=rs.getString("recipetitle")%><br>
                    조회수<%=rs.getInt("views")%><br>
                    소요시간<%=rs.getString("usetime")%></a>
				</td>
                    <%
                    if (count > 0 && count % 4 == 0) {	
                    %>
			    </tr>
			    <tr>
                    <%
                    }
			        count++;
		            }
                    %>
                


                 <%
    
            } catch(SQLException ex) {
                out.print(ex.getMessage());
                ex.printStackTrace();
            } finally {
                // Close Statement
                if (rs !=null) try { rs.close(); } catch(SQLException ex) {}
                if (stmt !=null) try { stmt.close(); } catch(SQLException ex) {}
                // Close Connection
                if (conn !=null) try { conn.close(); } catch(SQLException ex) {}
            }
          
            %>
            </table>
        </div>
    </body>
</html>
