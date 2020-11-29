<%-- 
    Document   : users
    Created on : 2020. nov. 25., 15:57:16
    Author     : Judit
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%! String role="session.getAttribute('role')";
String uname = (String)"session.getAttribute('logged')";%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <nav >
                <div style="align:left">
                    <i>Üdv <% String uname = (String)session.getAttribute("logged");
                        out.println(uname); %>!</i>
                        <div style="float:right">
                                <c:if test="${role eq 'admin'}">
                                    <a href="movies.jsp" >Movies</a>
                                </c:if>
                            <a href="logout.jsp" >Kijelentkezés</a>
                        </div>
                    </div>
                </nav>
        <h1>Hello World!</h1>
        felh:<% out.println(uname); %>
    </body>
</html>
