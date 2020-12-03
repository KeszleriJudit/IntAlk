<%-- 
    Document   : checkadd
    Created on : 2020. nov. 29., 22:38:23
    Author     : Norbi
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
    private static String encryptPassword(String password) {
        String sha1 = "";
        try {
            MessageDigest crypt = MessageDigest.getInstance("SHA-1");
            crypt.reset();
            crypt.update(password.getBytes("UTF-8"));
            sha1 = byteToHex(crypt.digest());
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return sha1;
    }

    private static String byteToHex(final byte[] hash) {
        Formatter formatter = new Formatter();
        for (byte b : hash) {
            formatter.format("%02x", b);
        }
        String result = formatter.toString();
        formatter.close();
        return result;
    }
%>
<c:choose>
    <c:when test="${!empty param.add}">
        <sql:query var="uniquecheck" dataSource="${mydb}">
            SELECT * FROM users WHERE username='${param.username}'
        </sql:query>   
        <c:choose>
            <c:when test="${uniquecheck.rowCount ne 0}">
                <jsp:forward page="users.jsp">
                    <jsp:param name="errormsg" value="<h5 class=\"err\">Ez a felhasználónév már foglalt.</h5>"/>
                </jsp:forward>                        
            </c:when>
            <c:otherwise>
                <% String sha1pwd = encryptPassword(request.getParameter("password"));%>                       
                <sql:update var="eredmeny" dataSource="${mydb}">
                    INSERT INTO users (username, password)
                    VALUES ('${param.username}', '<%=sha1pwd%>')
                </sql:update> 
                <c:redirect url="users.jsp"/>                          
            </c:otherwise>
        </c:choose>     
    </c:when>
    <c:otherwise>
        <c:redirect url="users.jsp"/>   
    </c:otherwise>
</c:choose>