                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        <%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import ="java.util.ArrayList" %>

<html>
    <head>
        <title>PROFILE</title>
    </head>
    <body>
        <% // MySQL JDBC Driver Loading
        String id=(String)session.getAttribute("id");

                Class.forName("com.mysql.cj.jdbc.Driver"); 
                Connection conn =null;
                Statement stmt =null;
                ResultSet rs =null;
                try {
                              
                    String jdbcDriver ="jdbc:mysql://localhost:3306/TestDB?serverTimezone=UTC"; 
                    String dbUser ="tester"; //mysql id
                    String dbPass ="1234"; //mysql password
                    String query ="select * from CLIENT"; //query
                    // Create DB Connection
                    conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
                    // Create Statement
                    stmt = conn.createStatement();
                    // Run Qeury
                    rs = stmt.executeQuery(query);
                    // Print Result (Run by Query)

                    ArrayList<String> id_list = new ArrayList<String>();

                    while(rs.next()) {
                        id_list.add(rs.getString("ID"));
                        
                    }

                    for(int i=0;i<id_list.size();i++){
                        if(id.equals(id_list.get(i))){
                            out.print(rs.getString("NAME"));
                            out.print(id);
                            // out.print(rs.getString("LIVE"));
                            // out.print(rs.getString("POINT"));
                        }
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