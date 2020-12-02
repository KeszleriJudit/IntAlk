<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : login
    Created on : 2020. nov. 24., 13:34:58
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:if test="${ sessionScope.logged != null}">
    <c:redirect url="movies.jsp"/>
</c:if>    

<sql:setDataSource 
   var="mydb" 
    url="jdbc:ucanaccess://C:/Users/Judit/Documents/moviedb.accdb" 
    driver="net.ucanaccess.jdbc.UcanaccessDriver" 
    user=""
    password=""
    scope="session"/>

<!DOCTYPE html>
<html lang="hu">

<head>
  <link rel="stylesheet" href="login.css">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bejelentkezés</title>
</head>

<body>
  <div class="login-page">
    <div class="form">
      <h2>Bejelentkezés</h2>
      <form class="login" action="check.jsp" method="POST">
        <input type="text" name="username" placeholder="Felhasználónév" />
        <input type="password" name="password" placeholder="Jelszó" />
        <c:if test="${!empty param.errormsg}" >
            <h5 style="color:red">${param.errormsg}</h5>
        </c:if> 
        <input type="submit" class="gomb" name="login" value="Bejelentkezés">
        <p class="message">Még nem regisztrált? <a href="register.jsp">Regisztráció</a></p>
      </form>
    </div>
  </div>
</body>
</html>