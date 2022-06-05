<!--장영훈-->
<%@ page contentType ="text/html; charset=utf-8"%>
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
        <title>검색결과</title>
        <meta charset="utf-8">
        
        <link rel="stylesheet" type="text/css" href="allstandard.css">
    </head>
    <body>
        <% // MySQL JDBC Driver Loading
                //1. getParameter로 index.html에서 검색한 값을 search로 가져오기
                String search = request.getParameter("search");

                Class.forName("com.mysql.cj.jdbc.Driver"); 
                Connection conn =null;
                Statement stmt =null;
                ResultSet rs =null;

                
                
                //String[] list = search.split(" ");
                //out.print(Arrays.toString(list));
                int i, k;
                //for(i = 0; i < list.length; i++){
                //        out.print("[" + i + "]" + list[i]);
                //   }
                //for(k = i; k < 10; k++){
                //    list[k] = " ";
                //}
                
                //List<String> list = Arrays.asList(search.split(" "));

                String[] arr = search.split(" ");
                List<String> list = new ArrayList<>(Arrays.asList(arr));

                for(i = 0; i < list.size(); i++){}

                for(k = i; k < 10; k++){
                    list.add("");
                }

                String[] newArr = list.toArray(new String[0]);


                try {
                    String jdbcDriver ="jdbc:mysql://localhost:3306/TestDB?serverTimezone=UTC"; 
                    String dbUser ="tester"; //mysql id
                    String dbPass ="1234"; //mysql password

                    //for(int k = 0; k <= i; k++){
                    //
                    //}

                    //String query ="select * from recipe"; //query
                    //String query = "select *from recipe where recipe LIKE '%감자%두부%'";
                    String query = "select *from recipe where recipe LIKE '%" + newArr[0] + "%" + newArr[1] + "%" + newArr[2] + "%" + newArr[3] + "%" + newArr[4] + "%" + newArr[5] + "%" + newArr[6] + "%" + newArr[7] + "%" + newArr[8] + "%" + newArr[9] +"%';";              

                    //if(i == 1){
                        //String query = "select *from recipe where recipe LIKE '%" + newArr[0] + "%" + newArr[1] +"%" newArr[2] + "%" + newArr[3] + "%" + newArr[4] + "%" + newArr[5] + "%" + newArr[6] + "%" + newArr[7] + "%" + newArr[8] + "%" + newArr[9] + "%';";   
                    //}


                    
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
            <h1>SEARCH FOOD</h1>
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
  
            %>
<%



    // 2. db 재료(recipe)를 연동시키기
    // 3. 받아온 값을 db에서 찾고 받아서 출력하기
    // 4. 페이지 띄우기

%>