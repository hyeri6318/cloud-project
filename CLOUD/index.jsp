<%@ page contentType ="text/html; charset=utf-8" %>

<%
    if(session.getAttribute("id")==null){ // 로그인이 안되어 있으면 로그인 페이지로 돌아감
        out.println("<a href='login.jsp'>로그인</a>");
    } else{
        String id=(String)session.getAttribute("id");
        out.println(id+" 반갑습니다.<br>");
    }
%>