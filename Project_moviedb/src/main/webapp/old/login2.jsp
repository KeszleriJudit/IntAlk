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
<html lang="hu">

<head>
  <link rel="stylesheet" href="style.css">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bejelentkezés</title>
</head>

<body>
  <div class="login-page">
    <div class="form">
      <h2>Film pontozás</h2>
      <form class="login" action="check.jsp" method="POST">
        <input type="text" name="username" placeholder="felhasználónév" />
        <input type="password" name="password" placeholder="jelszó" />
        <c:if test="${!empty param.errormsg}">
            ${param.errormsg}
        </c:if> 
        <input type="submit" class="gomb" name="login" value="Bejelentkezés">
        <p class="message">Még nem regisztrált? <a href="register.jsp">Regisztráció</a></p>
      </form>
    </div>
  </div>
</body>
</html>