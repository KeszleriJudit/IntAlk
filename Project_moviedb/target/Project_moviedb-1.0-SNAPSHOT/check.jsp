<%-- 
    Document   : check
    Created on : 2020. nov. 25., 15:55:48
    Author     : Judit
--%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "func" uri = "http://java.sun.com/jsp/jstl/functions"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:choose>
    <c:when test="${!empty param.login}">
        <% session.setAttribute("logged", null);%>
        <c:choose>
            <c:when test="${(!empty param.username) && (!empty param.password)}">
                <sql:query var="eredmeny" dataSource="${mydb}">
                    SELECT * FROM users WHERE StrComp(username, '${param.username}', 0) = 0 AND StrComp(password, '${param.password}', 0) = 0
                </sql:query>
                <c:choose>
                    <c:when test="${eredmeny.rowCount != 0}">
                        <% session.setAttribute("logged", request.getParameter("username"));%>
                        <c:forEach var="person" items="${eredmeny.rows}">
                               <c:if test="${person.role == 'true'}"> 
                                <% session.setAttribute("role", "admin");%>
                                </c:if>
                        </c:forEach>
                        
                        <jsp:forward page="movies.jsp"></jsp:forward>
                    </c:when>
                    <c:otherwise>
                        <jsp:forward page="login.jsp">
                            <jsp:param name="errorMsg" value="Nem találtunk ilyen felhasználót, kérjük ellenőrizze a megadott adatokat, vagy regisztráljon honlapunkra."/>
                        </jsp:forward>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <jsp:forward page="login.jsp">
                            <jsp:param name="errorMsg" value="A felhasználónév és a jelszó megadása kötelező"/>
                </jsp:forward>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <jsp:forward page="login.jsp">
            <jsp:param name="errorMsg" value="A program használata előtt be kell jelentkezni"/>
        </jsp:forward>
    </c:otherwise>
</c:choose>