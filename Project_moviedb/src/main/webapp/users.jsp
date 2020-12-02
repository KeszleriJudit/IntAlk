<%-- 
    Document   : admin
    Created on : 2020. nov. 29., 20:24:57
    Author     : Norbi
--%>

<%@ page import="java.text.DecimalFormat"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>

<% if (session.getAttribute("logged") != null && session.getAttribute("role") == "admin") {

%>

<% String role = "session.getAttribute('role')";
    String uname = (String) session.getAttribute("logged");
    pageContext.setAttribute("uname", uname); %>  

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<sql:query var="felhasznalok" dataSource="${mydb}">
    SELECT * FROM users
</sql:query>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin felület</title>
        <script type="text/javascript" src="scripts.js"></script>
        <script>
            function hideForm() {
                document.getElementById('create_form').style.display = "none";
            }
            function addNewUser() {
                document.getElementById('create_form').style.display = "block";
                window.scrollTo(0, document.body.scrollHeight);
            }
            function blankCheck() {
                var jelszo = document.getElementById("jelszo").value;
                var jelszo2 = document.getElementById("jelszo2").value;
                if (document.getElementById("jelszo").value.length <= 5) {
                    document.getElementById('erroruzenet').innerHTML = "A jelszó legalább 6 karakter hosszú legyen!";
                    return false;
                } else if (jelszo != jelszo2) {
                    document.getElementById('erroruzenet').innerHTML = "A két jelszó nem egyezik meg!";
                    return false;
                } else {
                    return true;
                }
            }
        </script>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="style.css">
    </head>
    <body class="bg-light">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div style="align:left" class="navbar-nav mr-auto">

                <div style="float:right">
                    <c:if test="${role eq 'admin'}">
                        <a class="text-light nav-item" href="movies.jsp" >Filmek </a> &nbsp
                    </c:if>
                    <a class="text-light nav-item" href="logout.jsp" > Kijelentkezés</a>
                </div>
            </div>
        </nav>
        <div class="container-fluid">
            <br>
            <h1>Felhasználók</h1>
            <table  class="table col-12" style="align-content: center">
                <thead class="thead-dark">
                    <tr >
                        <th scope="col">Felhasználónév</td>
                        <th scope="col">Jelszó</td>
                        <th scope="col">Jogosultság</td>
                        <th scope="col"></td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="sor" items="${felhasznalok.rows}">
                    <form method="post" action="helpers.jsp">     
                        <tr>
                            <td><c:out value="${sor.username}"/></td>
                            <td><c:out value="${sor.password}"/></td> 
                        <input type="hidden" name="id" value="${sor.userID}"/>
                        <td>
                            <label><input type="radio" name="R1" value="admin" <c:if test="${sor.role=='true'}">checked</c:if>> Admin &nbsp;</label> 
                            <label><input type="radio" name="R1" value="user" <c:if test="${sor.role=='false'}">checked</c:if>> User </label>
                        </td>
                        <td><button id = "button${sor.userID}" name="update" type="submit" class="btn btn-info">Mentés</button>
                          &nbsp;&nbsp;
                        <button id = "button${sor.userID}" name="deleteuser" type="submit" class="btn btn-danger">Törlöm</button></td>
                        </tr>
                    </form>
                </c:forEach>  
                </tbody>
            </table>
            <input class="btn btn-secondary" type="button" value="&#10010 Új felhasználó" onclick="addNewUser()">
            <br>
            <h5 class="err" id="erroruzenet"></h5>
            <c:if test="${!empty param.errormsg}">
                <br> <h5 style="color:red">${param.errormsg}</h5>
            </c:if> 
            <br>
            <div style="display: none;" id="create_form">
                <br>
                <h3>Új felhasználó hozzáadása</h3>
                <form action="checkadd.jsp" method="post" onsubmit="return blankCheck()" >
                    <div class="form-group">
                        <input class="form-control" style="width:35%;" type="text" name="username" id="felh" placeholder="Felhasználónév (kötelező)" required/>
                    </div>
                    <div class="form-group">
                        <input class="form-control" style="width:35%;" type="password" name="password" id="jelszo" placeholder="Jelszó (legalább 6 karakter)" required/>
                    </div>
                    <div class="form-group">
                        <input class="form-control" style="width:35%;" type="password" name="password2" id="jelszo2" placeholder="Jelszó újra" required/>
                    </div>
                    <input class="btn btn-info" type="submit" value="Hozzáadás" name="add">
                    <button class="btn btn-secondary" type="button" onclick="hideForm()">Mégse</button>
                    <br>
                </form>
                <br>
            </div>
        </div>
    </body>
</html>
<% } else {%>
<jsp:forward page="login.jsp">
    <jsp:param name="errorMsg" value="Kérjük jelentkezzen be."/>
</jsp:forward>
<%}%> 
