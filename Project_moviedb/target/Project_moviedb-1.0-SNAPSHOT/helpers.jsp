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
<% System.out.println("atiranyitas ok");%>
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
        <c:redirect url="movies.jsp"/>
    </c:when>
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
        <c:redirect url="movies.jsp"/>
    </c:when>
    <c:when test="${param.create != null}">
        <sql:query var="isExists" dataSource="${mydb}">
            SELECT * FROM movies WHERE title = "${param.filmName}"
        </sql:query>  
        <c:choose>
            <c:when test="${isExists.rowCount != 0}">
                <jsp:forward page="movies.jsp">
                    <jsp:param name="errorMsg" value="Már szerepel a film az adatbázisunkban"/>
                </jsp:forward>
            </c:when>
            <c:otherwise>
                <sql:update var="film" dataSource="${mydb}">
                    INSERT INTO movies (title, year, category)
                    VALUES ("${param.filmName}", "${param.year}", "${param.category}")
                </sql:update> 
            </c:otherwise>   
        </c:choose>
        <c:redirect url="movies.jsp"/>         
    </c:when>                
    <c:when test="${param.deleteuser != null}">
        <sql:update var="deletedratings" dataSource="${mydb}">
            DELETE FROM rating
            WHERE userID = ${param.id} 
        </sql:update>
        <sql:update var="deleted" dataSource="${mydb}">
            DELETE FROM users
            WHERE userID = ${param.id} 
        </sql:update>
        <c:redirect url="users.jsp"/>
    </c:when>
    <c:when test="${param.update != null}">
        <% System.out.println("gomb ok");%>
        <% String ertek = request.getParameter("R1");
            pageContext.setAttribute("ertek", ertek);
        %>
        <% System.out.println(ertek);%>
        <c:choose>
            <c:when test="${ertek eq 'admin'}">
                <sql:update dataSource="${mydb}">
                    UPDATE users
                    SET role = true
                    WHERE userID = "${param.id}" 
                </sql:update>
                <c:redirect url="users.jsp"/>
            </c:when>
            <c:when test="${ertek eq 'user'}">
                <sql:update dataSource="${mydb}">
                    UPDATE users
                    SET role = false
                    WHERE userID = "${param.id}" 
                </sql:update>
                <c:redirect url="users.jsp"/>
            </c:when>
            <c:otherwise>
                <c:redirect url="users.jsp"/>
            </c:otherwise>            
        </c:choose>
    </c:when>            
    <c:otherwise>
        <c:redirect url="movies.jsp"/>
    </c:otherwise>
</c:choose>





