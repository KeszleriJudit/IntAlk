<%-- 
    Document   : logout
    Created on : 2020. nov. 25., 18:54:21
    Author     : Judit
--%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%session.invalidate();%>
<jsp:forward page="login.jsp">
    <jsp:param name="errorMsg" value="Kijelentkeztél"/>
</jsp:forward>