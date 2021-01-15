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
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"
        integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA=="
        crossorigin="anonymous" />
    <link href="../Css/CustomColors.css" rel="stylesheet" type="text/css" />
    <title>Secure Notes - Contacts</title>
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
    <nav class="navbar navbar-expand-lg navbar-dark btn-primary sticky-top" style="background-color:#189AB4">
        <a class="navbar-brand" href="../">Secure Notes</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="../">Home <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="#">Contacts</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="Settings.jsp">Settings</a>
                </li>
            </ul>

            <div class="dropdown">
                <input name="searchQuery" onclick="searchQueryChange()" oninput="searchQueryChange()" id="searchQuery"
                    data-toggle="dropdown" type="search" class="form-control" placeholder="Search" autocomplete="off"
                    aria-haspopup="true" aria-expanded="false" />
                <ul id="searchResults" style="overflow-y: auto; max-height: 200px" class="dropdown-menu bg-card"
                    role="menu" aria-labelledby="searchQuery">

                </ul>
            </div>
        </div>
    </nav>

    <button type="button" class="btn btn-primary rounded-circle mb-4 mr-3 mb-sm-5 mr-sm-5"
        style="position: fixed; z-index: 100; right:0; bottom: 0;" data-toggle="modal" data-target="#addContactModal">
        <i class="material-icons pt-1 m-sm-2 pt-sm-1 pb-sm-1 fas fa-plus"></i>
    </button>
    <div id="savedAlert" class="alert alert-success alert-dismissible fade" role="alert">
        <strong>Saved</strong>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <%-- Add Contact Modal --%>
    <div class="modal fade" id="addContactModal" tabindex="-1" role="dialog" aria-labelledby="addContactModalTitle"
        aria-hidden="true">
        <form id="newContact" onsubmit="return handleSave(event);">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">New Contact</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="userId" value="<%=userId %>" />
                        <div class="form-group">
                            <label for="title">Name</label>
                            <input type="text" class="form-control" required name="name" id="name" placeholder="Name">
                        </div>
                        <div class="form-group">
                            <label for="mobileNo">Mobile No</label>
                            <input type="tel" class="form-control" id="mobileNo" required rows="4" name="mobileNo"
                                placeholder="Mobile No"></input>
                        </div>
                        <div class="form-group">
                            <label for="emailId">Email Id</label>
                            <input type="email" class="form-control" id="emailId" required rows="4" name="emailId"
                                placeholder="Email Id"></input>
                        </div>
                    </div>
                    <div id="errorSave" class="alert alert-danger fade hide" role="alert">
                        Error while saving notes.. Please check connectivity...
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Save</button>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <script src="../bootstrap/js/jquery.js" type="text/javascript"></script>
    <script src="../bootstrap/js/popper.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>

    <script>
        function handleSave(e) {
            $.ajax({
                url: 'ContactHandler',
                type: 'POST',
                dataType: 'text/plain',
                data: $("#newContact").serialize(),
                success: function (data, textStatus, jqXHR) {
                    console.log(data)
                    if (data === 'true') {
                        $("#savedAlert").addClass('show sticky-top');
                        setTimeout(function () {
                            $("#savedAlert").removeClass('show sticky-top');
                        }, 2000);
                        $("#addNotesModal").modal('toggle');
                        location.reload();
                    } else {
                        $("#errorSave").addClass('show');
                        setTimeout(function () {
                            $("#errorSave").removeClass('show');
                        }, 2000);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR)
                    if (jqXHR.responseText === 'true') {
                        $("#savedAlert").addClass('show sticky-top');
                        setTimeout(function () {
                            $("#savedAlert").removeClass('show sticky-top');
                            location.reload();
                        }, 2000);
                        $("#addNotesModal").modal('toggle');
                    } else {
                        $("#errorSave").addClass('show');
                        setTimeout(function () {
                            $("#errorSave").removeClass('show');
                        }, 2000);
                    }
                    $("#errorSave").addClass('show');
                    setTimeout(function () {
                        $("#errorSave").removeClass('show');
                    }, 2000);
                }
            })
            return false;
        }
    </script>
</body>

</html>