<%-- 
    Document   : helpers
    Created on : 2020. nov. 28., 17:36:18
    Author     : Judit
--%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "func" uri = "http://java.sun.com/jsp/jstl/functions"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<% String uname = (String) session.getAttribute("logged");
    pageContext.setAttribute("uname", uname);%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:choose>
    <c:when test="${param.delete != null}">
        <c:choose>
    <c:when test="${param.delete != null}">
        <sql:query var="users" dataSource="${mydb}">
            SELECT * FROM users WHERE username = "${uname}"
        </sql:query>
        <c:forEach var="name" items="${users.rows}">
            <c:set var="mynameID" value="${name.userID}"/> 
            <% pageContext.setAttribute("mynameID", pageContext.getAttribute("mynameID"));%>
        </c:forEach>
        <sql:update var="deleted" dataSource="${mydb}">
            DELETE FROM rating
            WHERE filmID = ${param.id} AND userID = ${mynameID}
        </sql:update>
        <jsp:forward page="movies.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:forward page="movies.jsp"/>
    </c:otherwise>
</c:choose>
    </c:when>
    <c:otherwise>
        
<c:choose>
    <c:when test="${!empty param.button}">
        <sql:query var="users" dataSource="${mydb}">
            SELECT * FROM users WHERE username = "${uname}"
        </sql:query>
        <c:forEach var="name" items="${users.rows}">
            <c:set var="mynameID" value="${name.userID}"/> 
            <% pageContext.setAttribute("mynameID", pageContext.getAttribute("mynameID"));%>
        </c:forEach>
            <sql:query var="check" dataSource="${mydb}">
                SELECT * FROM rating WHERE userID = "${mynameID}" AND filmID = "${param.id}"
            </sql:query>   
                <c:choose>
                    <c:when test="${check.rowCount != 0}">
                        <sql:update var="updated" dataSource="${mydb}">
                            UPDATE rating
                            SET value = "${param.button}"
                            WHERE userID = "${mynameID}" AND filmID = "${param.id}"
                        </sql:update>
                    </c:when>
                    <c:otherwise>
                        <sql:update var="r" dataSource="${mydb}">
                            INSERT INTO rating (filmID, userID, value)
                             VALUES ("${param.id}", "${mynameID}", "${param.button}")
                        </sql:update> 
                    </c:otherwise>
                </c:choose>
     
        
        <jsp:forward page="movies.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:forward page="movies.jsp"/>
    </c:otherwise>
</c:choose>

    </c:otherwise>
</c:choose>


                            


