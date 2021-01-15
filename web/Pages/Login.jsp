<%-- 
    Document   : Register
    Created on : Dec 30, 2020, 8:38:41 PM
    Author     : Meghanath Nalawade
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Secure Notes - Login</title>
        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        
    </head>
    <body >
        <nav class="navbar navbar-expand-lg navbar-dark bg-navbar" style="background-color:#189AB4">
            <a class="navbar-brand" href="#">Secure Notes</a>
        </nav>
        <div class="card  border-info mt-5 ml-auto mr-auto" style="max-width: 25rem;">

            <ul class="nav nav-tabs"  style="background-color: #75E6DA;" id="mainTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="login-tab" data-toggle="tab" href="#login" role="tab" aria-controls="login" aria-selected="true">Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="register-tab" data-toggle="tab" href="#register" role="tab" aria-controls="register" aria-selected="false">Register</a>
                </li>
            </ul>
            <div class="tab-content" style="background-color: #D4F1F4" id="mainTabContent">
                <div  class="tab-pane fade show active" id="login" role="tabpanel" aria-labelledby="login-tab">
                    <div class="card-header">
                        <h1 class="text-center">Login</h1>
                    </div>
                    <%
                        HttpSession s = request.getSession();
                        String error = (String) s.getAttribute("error");
                        if (error != null) {
                    %>
                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        <strong>Error </strong> <%=error%>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                        <%  s.removeAttribute("error");
                        }%>
                    <div class="card-body">
                        <form action="../LoginHandler" method="post">
                            <div class="form-group">
                                <label for="exampleInputEmail1">Email address</label>
                                <input type="email" class="form-control" required id="emailId" name="emailId" placeholder="Enter email">

                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword1">Password</label>
                                <input type="password" class="form-control" required name="password" id="password" placeholder="Password">
                            </div>
                            <INPUT TYPE="submit" value="Login" >
                        </form>
                    </div>
                </div>
                <div  class="tab-pane fade" id="register" role="tabpanel" aria-labelledby="register-tab">
                    <div class="card-header">
                        <h1 class="text-center">Register</h1>
                    </div>
                    <%
                        if (error != null) {
                    %>
                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        <strong>Error </strong> <%=error%>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <% }%>
                    <div class="card-body">
                        <form action="../RegisterHandler" method="post" onsubmit="return submitRegistrationForm(event);">
                            <label>Name</label>
                            <div class="row">
                                <div class="col">
                                    <input type="text" name="fname" required id="rfname" class="form-control" placeholder="First name">
                                </div>
                                <div class="col">
                                    <input type="text" name="lname" required id="rlname" class="form-control" placeholder="Last name">
                                </div>
                            </div>
                            <div class="form-group">
                                <label >Email address</label>
                                <input type="email" class="form-control" required name="emailId" placeholder="Enter email">

                            </div>
                            <div class="form-group">
                                <label >Password</label>
                                <input type="password" class="form-control" required name="password" id="rPassword" placeholder="Password">
                            </div>
                            <div class="form-group">
                                <label >Confirm Password</label>
                                <input type="password" class="form-control" name="confirm-password" id="rConfirmPassword" placeholder="Confirm Password">
                                <div id="confirm-password-error" class="text-danger"></div>
                            </div>

                            <INPUT TYPE="submit" value="Register"  >
                        </form>
                    </div>
                </div>

            </div>

            <script src="../bootstrap/js/jquery.js" type="text/javascript"></script>
            <script src="../bootstrap/js/popper.js" type="text/javascript"></script>
            <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
            
            
            <script>
                function submitRegistrationForm(e){
                    if($("#rPassword").val()!==$("#rConfirmPassword").val()){
                        $("#confirm-password-error").html("Confirm password does not match !")
                        $("#rConfirmPassword").focus();
                        $("#rConfirmPassword").select();

                        return false;
                    }
                    return true;
                }
            </script>

    </body>
</html>
