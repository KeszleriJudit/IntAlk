<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : register
    Created on : 2020. nov. 24., 13:35:43
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="hu">

<head>
    <link rel="stylesheet" href="login.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Regisztráció</title>


    <script>
        function blankCheck() {

            var jelszo = document.getElementById("jelszo").value;
            var jelszo2 = document.getElementById("jelszo2").value;

            if (document.getElementById("felh").value == "" || document.getElementById("jelszo").value == "" || document.getElementById("jelszo2").value == "") {
                document.getElementById('erroruzenet').innerHTML = "Töltse ki az összes mezőt!";
                return false;
            } else if (document.getElementById("jelszo").value.length <= 5) {
                document.getElementById('erroruzenet').innerHTML = "A jelszó legalább 6 karakter hosszú legyen!";
                return false;
            } else if (jelszo != jelszo2) {
                document.getElementById('erroruzenet').innerHTML = "A két jelszó mező nem egyezik meg!";
                return false;
            } else {
                return true;
            }
        }
    </script>
</head>
<body>
    <div class="login-page">
        <div class="form">
            <h2>Regisztráció</h2>
            <form class="login" action="check.jsp" method="POST" onSubmit="return blankCheck()">      
                <input type="text" name="username" id="felh" placeholder="Felhasználónév (kötelező)" />
                <input type="password" name="password" id="jelszo" placeholder="Jelszó (legalább 6 karakter)" />
                <input type="password" name="password2" id="jelszo2" placeholder="Jelszó újra" />
                <h5 class="err" id="erroruzenet"></h5>
                <c:if test="${!empty param.errormsg}">
                    ${param.errormsg}
                </c:if> 
                <input type="submit" class="gomb" name="register" value="Regisztráció">
            </form>
        </div>
    </div>
</body>
</html>