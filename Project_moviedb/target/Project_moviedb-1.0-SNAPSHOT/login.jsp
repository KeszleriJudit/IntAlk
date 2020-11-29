<%-- 
    Document   : login
    Created on : 2020. nov. 25., 15:55:18
    Author     : Judit
--%>

<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<sql:setDataSource 
    var="mydb" 
    url="jdbc:ucanaccess://C:/Users/Judit/Documents/moviedb.accdb" 
    driver="net.ucanaccess.jdbc.UcanaccessDriver" 
    user=""
    password=""
    scope="session"
    />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
       <h1>Bejelentkezés</h1>
        <form action="check.jsp" method="POST">
            Felhasználónév: <input type="text" name="username"><br>
            Jelszó: <input type="password" name="password"><br>
            <input type="submit" name="login" value="Bejelentkezés">
        </form>
       
       <c:if test="${!empty param.errorMsg}">
            <hr>
            ${param.errorMsg}
        </c:if>
        <c:if test="${empty mydb}">
            <p>Kérjük ellenőrizze az AB kapcsolatot.</p>
        </c:if>
    </body>
</html>
