<%-- 
    Document   : movies
    Created on : 2020. nov. 25., 15:57:07
    Author     : Judit
--%>

<%@ page import="java.text.DecimalFormat"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<% if (session.getAttribute("logged") != null) { 
    
%>
<% String role="session.getAttribute('role')"; 
    String uname = (String) session.getAttribute("logged");
    pageContext.setAttribute("uname", uname); %>  
    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<sql:query var="filmek" dataSource="${mydb}">
    SELECT * FROM movies
</sql:query>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Movie DB</title>
        <script src="scripts.js"></script>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="style.css">
        </head>
      
        <body class="bg-light">
            
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div style="align:left" class="navbar-nav mr-auto">
                    
                        <div style="float:right">
                                <c:if test="${role eq 'admin'}">
                                    <a class="text-light nav-item" href="users.jsp" >Felhasználók </a> &nbsp
                                </c:if>
                            <a class="text-light nav-item" href="logout.jsp" > Kijelentkezés</a>
                        </div>
                    </div>
                <i class="text-light">Üdv <%out.println(uname);%>!</i>
                </nav>
                        
                <div class="container-fluid">
                    <br>
                <h1>Filmek</h1>
                <table  class="table col-12" style="align-content: center">
                    <thead class="thead-dark">
                        <tr >
                            <th scope="col">Film címe</td>
                            <th scope="col">Év</td>
                            <th scope="col">Kategória</td>
                            <th scope="col">Értékelés</td>
                            <th scope="col"></td>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="sor" items="${filmek.rows}">
                          <% int sum = 0; 
                             int count = 0;%>
                    <form method="post" action="helpers.jsp">
                            <tr>
                                <td><c:out value="${sor.title}"/></td>
                                <td><c:out value="${sor.year}"/></td>
                                <td><c:out value="${sor.category}"/></td>
                                <td>
                                <sql:query var="ratings" dataSource="${mydb}">
                                    SELECT * FROM rating WHERE filmID = ${sor.filmID}
                                </sql:query>
                                <c:forEach var="rates" items="${ratings.rows}">
                                    <c:set var="rate" value="${rates.value}"/>
                                    <% sum += (Integer)pageContext.getAttribute("rate"); 
                                       count += 1; %>
                                </c:forEach> 
                                    <% double avg = (double)sum/(double)count;
                                        DecimalFormat df = new DecimalFormat("#.#");
                                        out.println(df.format(avg)+"/5");%>
                                </td>
                                <td> 
                                    <sql:query var="users" dataSource="${mydb}">
                                        SELECT * FROM users WHERE username = "${uname}"
                                    </sql:query>
                                    <c:forEach var="name" items="${users.rows}">
                                        <c:set var="mynameID" value="${name.userID}"/> 
                                        <% pageContext.setAttribute("mynameID", pageContext.getAttribute("mynameID"));%>
                                    </c:forEach>
                                    <sql:query var="check" dataSource="${mydb}">
                                        SELECT * FROM rating WHERE userID = "${mynameID}" AND filmID = "${sor.filmID}"
                                    </sql:query>   
                                    <c:choose>
                                        <c:when test="${check.rowCount != 0}">
                                            <c:forEach var="rate" items="${check.rows}">
                                                <c:set var="myrate" value="${rate.value}"/> 
                                                <% pageContext.setAttribute("myrate", pageContext.getAttribute("myrate"));%>
                                            </c:forEach>
                                            
                                            <label id="star1${sor.filmID}" class="star1${myrate}${sor.filmID}" onclick="selected('1',${sor.filmID})"><input type="radio" name = "stars${sor.filmID}" value ='1' hidden><span style="font-size: 180%">&#128970;</span></input></label>
                                            <label id="star2${sor.filmID}" class="star2${myrate}${sor.filmID}" onclick="selected('2',${sor.filmID})"><input type="radio" name = "stars${sor.filmID}"  value ='2' hidden><span style="font-size: 180%">&#128970;</span></input></label>
                                            <label id="star3${sor.filmID}" class="star3${myrate}${sor.filmID}" onclick="selected('3',${sor.filmID})"><input type="radio" name = "stars${sor.filmID}"  value ='3' hidden><span style="font-size: 180%">&#128970;</span></input></label>
                                            <label id="star4${sor.filmID}" class="star4${myrate}${sor.filmID}" onclick="selected('4',${sor.filmID})"><input type="radio" name = "stars${sor.filmID}"  value ='4' hidden><span style="font-size: 180%">&#128970;</span></input></label>
                                            <label id="star5${sor.filmID}" class="star5${myrate}${sor.filmID}" onclick="selected('5',${sor.filmID})"><input type="radio" name = "stars${sor.filmID}"  value ='5' hidden><span style="font-size: 180%">&#128970;</span></input></label><br>
                                            <button id = "button${sor.filmID}" name="button" type="submit" class="btn btn-secondary">Újra értékelem</button>
                                            <input type="hidden" name="id" value="${sor.filmID}"/>
                                            <script>checking(${myrate},${sor.filmID})</script>
                                            
                                            <button id = "button${sor.filmID}" name="delete" type="submit" class="btn btn-danger" onclick="del()">Törlöm</button>
                                        </c:when>
                                        <c:otherwise>
                                            <label id="star1${sor.filmID}" class="stars" onmouseover="starcolor('yellow',${sor.filmID},'1')" onmouseout="starcolor('black',${sor.filmID},'1')" onclick="selected('1',${sor.filmID})"><input type="radio" name = "stars${sor.filmID}" value ='1' hidden><span style="font-size: 180%">&#128970;</span></input></label>
                                            <label id="star2${sor.filmID}" class="stars" onmouseover="starcolor('yellow',${sor.filmID},'2')" onmouseout="starcolor('black',${sor.filmID},'2')" onclick="selected('2',${sor.filmID})"><input type="radio" name = "stars${sor.filmID}"  value ='2' hidden><span style="font-size: 180%">&#128970;</span></input></label>
                                            <label id="star3${sor.filmID}" class="stars" onmouseover="starcolor('yellow',${sor.filmID},'3')" onmouseout="starcolor('black',${sor.filmID},'3')" onclick="selected('3',${sor.filmID})"><input type="radio" name = "stars${sor.filmID}"  value ='3' hidden><span style="font-size: 180%">&#128970;</span></input></label>
                                            <label id="star4${sor.filmID}" class="stars" onmouseover="starcolor('yellow',${sor.filmID},'4')" onmouseout="starcolor('black',${sor.filmID},'4')" onclick="selected('4',${sor.filmID})"><input type="radio" name = "stars${sor.filmID}"  value ='4' hidden><span style="font-size: 180%">&#128970;</span></input></label>
                                            <label id="star5${sor.filmID}" class="stars" onmouseover="starcolor('yellow',${sor.filmID},'5')" onmouseout="starcolor('black',${sor.filmID},'5')" onclick="selected('5',${sor.filmID})"><input type="radio" name = "stars${sor.filmID}"  value ='5' hidden><span style="font-size: 180%">&#128970;</span></input></label><br>
                                            <button id = "button${sor.filmID}" name="button" type="submit" class="btn btn-secondary">Értékelem</button>
                                            <input type="hidden" name="id" value="${sor.filmID}"/>
                                        </c:otherwise>
                                    </c:choose>

                                    
                                </td>
                            </tr>
                    </form>
                        </c:forEach>
                    </tbody>

                </table>
                <button class="btn btn-secondary"> &#10010 Új film</button>
            </div>
            </body>
        </html>

        <% } else {%>
        <jsp:forward page="login.jsp">
            <jsp:param name="errorMsg" value="Kérjük jelentkezzen be."/>
        </jsp:forward>
        <%}%>  
