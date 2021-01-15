<%-- 
    Document   : Contacts
    Created on : Jan 2, 2021, 9:55:22 PM
    Author     : Meghanath Nalawade
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />
        <link href="../Css/CustomColors.css" rel="stylesheet" type="text/css"/>
        <title>Secure Notes - Settings</title>
    </head>
    <%-- Checks User Login --%>
    <%
        int userId = -1;
        for (Cookie c : request.getCookies()) {
            if (c.getName().equals("userId")) {
                try {
                    userId = Integer.parseInt(c.getValue());
                } catch (Exception ex) {
                    userId = -1;
                }
            }
        }
        if (userId == -1) {
            response.sendRedirect("Login.jsp");
        }
    %>
    <body class="bg-home">
        <%-- Navigation bar --%>
        <nav class="navbar navbar-expand-lg navbar-dark btn-primary sticky-top"  style="background-color:#189AB4">
            <a class="navbar-brand" href="../">Secure Notes</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="../">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Contacts.jsp">Contacts</a>
                    </li>

                    <li class="nav-item active">
                        <a class="nav-link" href="#">Settings</a>
                    </li>
                </ul>
            </div>
        </nav>  
        
        
        
        <script src="../bootstrap/js/jquery.js" type="text/javascript"></script>
        <script src="../bootstrap/js/popper.js" type="text/javascript"></script>
        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>
