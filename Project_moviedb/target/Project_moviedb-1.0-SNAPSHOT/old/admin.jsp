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

<sql:setDataSource 
   var="mydb" 
    url="jdbc:ucanaccess://E:/moviedb.accdb" 
    driver="net.ucanaccess.jdbc.UcanaccessDriver" 
    user=""
    password=""
    scope="session"/>


<% if (session.getAttribute("logged") != null && session.getAttribute("role") == "admin") { 
    
%>

<% String role="session.getAttribute('role')"; 
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
        <script src="adminscripts.js"></script>
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
        <div class="container-fluid"></div>
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
                               
                               Admin <input type="radio" name="R1" 
                                    value="admin" <c:if test="${sor.role=='true'}">checked</c:if>>
                               User <input type="radio" name="R1" 
                                    value="user" <c:if test="${sor.role=='false'}">checked</c:if>>
                               
                                 <td><button id = "button${sor.userID}" name="update" type="submit" class="btn btn-danger">Mentés</button></td>
                               
                           </td> 
                                                     
                           
                           <td><button id = "button${sor.userID}" name="deleteuser" type="submit" class="btn btn-danger">Törlöm</button></td>
                           
                        </tr>
                        </form>
                            
                        </c:forEach>  
                        
                    </tbody>
            </table>
        </div>
        <div class="form">
            <h2>Felhasználó hozzáadása</h2>
            <form class="login" action="checkadd.jsp" method="POST" onSubmit="return blankCheck()">      
                <input type="text" name="username" id="felh" placeholder="Felhasználónév (kötelező)" />
                <input type="password" name="password" id="jelszo" placeholder="Jelszó (legalább 6 karakter)" />
                <h5 class="err" id="erroruzenet"></h5>
                <c:if test="${!empty param.errormsg}">
                    ${param.errormsg}
                </c:if> 
                <input type="submit" class="gomb" name="add" value="Hozzáadás">
            </form>
        </div>
        
    </body>
</html>

<% } else {%>
        <jsp:forward page="login.jsp">
            <jsp:param name="errorMsg" value="Kérjük jelentkezzen be."/>
        </jsp:forward>
        <%}%> 
