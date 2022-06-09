<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import ="java.util.ArrayList" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
String id = (String)session.getAttribute("id");

if(id==null){%>
<script>alert('로그인 후 접속 가능합니다.');</script>
<script>history.go(-1);</script>
<%} else { 
    response.sendRedirect("precipe.html");
}%>