<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 
    담당자 : 이혜리
    SFR-101 : 로그아웃 페이지
              로그아웃 버튼을 누르면 별도의 알림없이 바로 로그아웃이 되도록 구현
 --%>

<%
	session.invalidate();   // 세션값을 비워줌
    response.sendRedirect("index.html");    // 로그아웃 후 메인 페이지로 이동
%>