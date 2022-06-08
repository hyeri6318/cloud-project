<!--장영훈-->
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
        <title>표준양식레시피</title>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="allstandard.css">
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

            


        <div class="table">
            <thead>
                <tr>
                    <th><a href="#">CLOUD</a></th>
                    <th>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</th>
                    <th><a href="#">RECIPE</a></th>
                    <th><a href="#">OWN RECIPE</a></th>
                    <th><a href="#">RANKING</a></th>
                    <th><a href="#">PROFILE</a></th>
                </tr>
            </thead>
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
					<a href=<%="http://49.50.164.44/redirectHandler.jsp?num=" + rs.getString("num")%>>
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
