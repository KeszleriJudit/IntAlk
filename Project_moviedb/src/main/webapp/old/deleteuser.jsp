<%-- 
    Document   : deleteuser
    Created on : 2020. nov. 30., 19:19:39
    Author     : Norbi
--%>

<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "func" uri = "http://java.sun.com/jsp/jstl/functions"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<% String ertek=request.getParameter("R1"); %>

<c:choose>
    <c:when test="${param.deleteuser != null}">

        <sql:update var="deleted" dataSource="${mydb}">
                DELETE FROM users
                WHERE userID = ${param.id} 
            </sql:update>
            <jsp:forward page="admin.jsp"/>

    </c:when>
    <c:otherwise>            
        <c:choose>
            <c:when test="${ertek == 'admin'}">
                <sql:update var="update" dataSource="${mydb}">
                UPDATE users
                    SET role = true
                WHERE userID = ${param.id} 
                </sql:update>
                <jsp:forward page="users.jsp"/>
            </c:when>
            <c:otherwise>
                <sql:update var="update" dataSource="${mydb}">
                UPDATE users
                    SET role = false
                WHERE userID = ${param.id} 
            </sql:update>
            <jsp:forward page="users.jsp"/>
            </c:otherwise>            
        </c:choose>
    </c:otherwise>
</c:choose>



