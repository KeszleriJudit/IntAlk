<%-- 
    Document   : check
    Created on : 2020. nov. 25., 15:55:48
    Author     : Judit
--%>
<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.util.Formatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page import="java.util.HashSet"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "func" uri = "http://java.sun.com/jsp/jstl/functions"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<%!
//SHA-1 titkosítás, forrás: https://stackoverflow.com/questions/4895523/java-string-to-sha1
private static String encryptPassword(String password)
{
    String sha1 = "";
    try
    {
        MessageDigest crypt = MessageDigest.getInstance("SHA-1");
        crypt.reset();
        crypt.update(password.getBytes("UTF-8"));
        sha1 = byteToHex(crypt.digest());
    }
    catch(NoSuchAlgorithmException e)
    {
        e.printStackTrace();
    }
    catch(UnsupportedEncodingException e)
    {
        e.printStackTrace();
    }
    return sha1;
}

private static String byteToHex(final byte[] hash)
{
    Formatter formatter = new Formatter();
    for (byte b : hash)
    {
        formatter.format("%02x", b);
    }
    String result = formatter.toString();
    formatter.close();
    return result;
}
%>
<c:choose>
    <c:when test="${!empty param.login}">
        <% session.setAttribute("logged", null);%>
        <c:choose>
            <c:when test="${(!empty param.username) && (!empty param.password)}">
                <% String password =  encryptPassword(request.getParameter("password"));%>
                <sql:query var="eredmeny" dataSource="${mydb}">
                    SELECT * FROM users WHERE StrComp(username, '${param.username}', 0) = 0 AND StrComp(password, '<%=password%>', 0) = 0
                   
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
                            <jsp:param name="errormsg" value="Nem találtunk ilyen felhasználót, kérjük ellenőrizze a megadott adatokat, vagy regisztráljon honlapunkra."/>
                        </jsp:forward>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <jsp:forward page="login.jsp">
                            <jsp:param name="errormsg" value="A felhasználónév és a jelszó megadása kötelező"/>
                </jsp:forward>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test="${!empty param.register}">
        <c:choose>
            <c:when test="${(empty param.username) || (empty param.password)}">
                <jsp:forward page="register.jsp">
                    <jsp:param name="errormsg" value="<h5 class=\"err\">A felhasználói név/jelszó megadása kötelező.</h5>"/>
                </jsp:forward>
            </c:when>
            <c:otherwise>
                <sql:query var="uniquecheck" dataSource="${mydb}">
                    SELECT * FROM users WHERE username='${param.username}'
                </sql:query>   
                <c:choose>
                   <c:when test="${uniquecheck.rowCount eq 1}">
                        <jsp:forward page="register.jsp">
                            <jsp:param name="errormsg" value="<h5 class=\"err\">Ez a felhasználónév már foglalt.</h5>"/>
                        </jsp:forward>                        
                   </c:when>
                   <c:otherwise>
                        <% String sha1pwd =  encryptPassword(request.getParameter("password"));%>                       
                        <sql:update var="eredmeny" dataSource="${mydb}">
                            INSERT INTO users (username, password)
                            VALUES ('${param.username}', '<%=sha1pwd%>')
                        </sql:update> 
                        <jsp:forward page="login.jsp">
                            <jsp:param name="errormsg" value="<h5 class=\"valid\">Sikeresen regisztráció!</h5>"/>
                        </jsp:forward>                             
                   </c:otherwise>
                </c:choose>         
            </c:otherwise>
        </c:choose>
    </c:when>                     
    <c:otherwise>
        <jsp:forward page="login.jsp">
            <jsp:param name="errormsg" value="A program használata előtt be kell jelentkezni"/>
        </jsp:forward>
    </c:otherwise>
</c:choose>