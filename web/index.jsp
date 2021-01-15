<%@page import="database.Note"%>
<%@page import="java.util.ArrayList"%>
<%@page import="database.Notes"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : index
    Created on : Dec 30, 2020, 5:39:21 PM
    Author     : Meghanath Nalawade
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.DatabaseHandler"%>
<%@page import="java.sql.Connection"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Secure Notes</title>
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />
        <link href="Css/CustomColors.css" rel="stylesheet" type="text/css"/>
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
            response.sendRedirect("Pages/Login.jsp");
        }
    %>
    <body class="bg-home">
        <%-- Navigation bar --%>
        <nav class="navbar navbar-expand-lg navbar-dark btn-primary sticky-top"  style="background-color:#189AB4">
            <a class="navbar-brand" href="#">Secure Notes</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Pages/Contacts.jsp">Contacts</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="Pages/Settings.jsp">Settings</a>
                    </li>
                </ul>

                <div class="dropdown">
                    <input name="searchQuery" onclick="searchQueryChange()" oninput="searchQueryChange()" id="searchQuery" data-toggle="dropdown" type="search"
                           class="form-control" placeholder="Search"
                           autocomplete="off" aria-haspopup="true" aria-expanded="false"/>
                    <ul id="searchResults" style="overflow-y: auto; max-height: 200px" class="dropdown-menu bg-card" role="menu" aria-labelledby="searchQuery">

                    </ul>
                </div>

            </div>
        </nav>
        <%-- Alerts --%>
        <div id="savedAlert" class="alert alert-success alert-dismissible fade" role="alert">
            <strong>Saved</strong> 
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <%-- Add Note Fab --%>
        <button type="button" class="btn btn-primary rounded-circle mb-4 mr-3 mb-sm-5 mr-sm-5" style="position: fixed; z-index: 100; right:0; bottom: 0;"
                data-toggle="modal"  data-target="#addNotesModal">
            <i class="material-icons pt-1 m-sm-2 pt-sm-1 pb-sm-1 fas fa-plus"></i>
        </button>

        <div class="card-columns" style="margin-top: -60px;">
            <%
                ArrayList<Note> notes = new Notes().getNotes(userId);
                for (Note note : notes) {%>
            <div class="card text-white bg-card rounded border border-success">
                <div class="card-header">
                    <h5 class="card-title" > <%=note.getTitle()%> </h5>
                </div>
                <div class="card-body">
                    <p class="card-text" style="white-space: pre-line; overflow-y: auto; max-height: 90px"> <%=note.getContent()%> </p>
                    <button class="btn btn-outline-warning" onclick="editNote(<% out.print(note.getId()); %>)"
                            data-toggle="modal"  data-target="#editNotesModal"> <i class="fa fa-pen"></i></button>
                    <button class="btn btn-outline-danger" data-toggle="modal" data-target="#deleteConfirmModal"
                            onclick="deleteNote(<% out.print(note.getId()); %>, '<% out.print(note.getTitle()); %>')">
                        <i class="fa fa-trash"></i></button>


                </div>
            </div>

            <% }%>
        </div>
        <%-- Add Note Modal --%>
        <div class="modal fade" id="addNotesModal" tabindex="-1" role="dialog" aria-labelledby="addNotesModalTitle" aria-hidden="true">
            <form id="newNote"  onsubmit="return handleSave(event);"> 
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" >New Note</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="form-group">
                                <label for="title">Title</label>
                                <input type="text" class="form-control" required name="title" id="title" placeholder="Title">
                            </div>
                            <div class="form-group">
                                <label for="content">Content</label>
                                <textarea class="form-control" id="content" required rows="4" name="content" placeholder="Content"></textarea>
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

        <%-- Edit Note Modal --%>
        <div class="modal fade" id="editNotesModal" tabindex="-1" role="dialog" aria-labelledby="editNotesModalTitle" aria-hidden="true">
            <form id="editNote" onsubmit="return handleEditSave(event);"> 
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" >Edit Note</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="editId" id="editId"/>
                            <div class="form-group">
                                <label for="title">Title</label>
                                <input type="text" class="form-control" required name="editTitle" id="editTitle" placeholder="Title">
                            </div>
                            <div class="form-group">
                                <label for="content">Content</label>
                                <textarea class="form-control" id="editContent" required rows="4" name="editContent" placeholder="Content"></textarea>
                            </div>
                        </div>
                        <div id="errorEditSave" class="alert alert-danger fade hide" role="alert">
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

        <!-- deleteConfirmModal -->
        <div class="modal fade" id="deleteConfirmModal" tabindex="-1" role="dialog" aria-labelledby="deleteConfirmModalLabel">
            <div class="modal-dialog  rounded" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-warning">
                        <h5 class="modal-title" id="exampleModalLabel">Warning !!   </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <input type="hidden" id="deleteId"/>
                    <div class="modal-body">
                        Are you sure to delete <b id="deleteTitle"> </b> ?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                        <button type="button" class="btn btn-primary" onclick="handleDeletNote()">Yes</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="bootstrap/js/jquery.js" type="text/javascript"></script>
        <script src="bootstrap/js/popper.js" type="text/javascript"></script>
        <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        
        <script>

                            function  searchQueryChange() {
                                var query = $("#searchQuery").val();
                                var userId =<%=userId%>;
                                $.ajax({url: 'SearchNotes', type: 'GET', data: {"query": query, "userId": userId}, success: function (data, textStatus, jqXHR) {
                                        data = JSON.parse(data);
                                        var li = "";
                                        data.forEach((note) => {
                                        li += '<button class="btn m-2 btn-outlined-primary" '
                                                + 'onclick="editNote(' + note.id
                                                + ')" data-toggle="modal" data-toggle="tooltip" data-placement="bottom" title="' + note.content + '" data-target="#editNotesModal" >'
                                                + note.title + ' </button>';
                                        })
                                                console.log(li)
                                        $("#searchResults").html(li);
                                    }})
                            }


                            function deleteNote(id, title) {
                                $("#deleteTitle").html(title)
                                $("#deleteTitle").val(id);
                            }
                            function handleDeletNote() {
                                var id = $("#deleteTitle").val();
                                $.ajax({url: "DeleteNoteHandler", type: 'GET', data: {"id": id}, success: function (dat, textStatus, jqXHR) {
                                        $("#deleteConfirmModal").modal('toggle');
                                        location.reload()
                                    }, error: function (jqXHR, textStatus, errorThrown) {
                                        console.log(jqXHR)

                                    }})

                            }
                            function editNote(id) {
                                $.ajax({url: "NoteHandler", type: 'GET', data: {id: id}, success: function (dat, textStatus, jqXHR) {
                                        var data = JSON.parse(dat);
                                        $("#editId").val(id);
                                        $("#editTitle").val(data.title);
                                        $("#editContent").val(data.content);
                                    }, error: function (jqXHR, textStatus, errorThrown) {
                                        console.log(jqXHR)

                                    }})
                            }
                            function handleEditSave(e) {
                                $.ajax({url: 'NoteHandler', type: 'POST', data: $("#editNote").serialize(), success: function (data, textStatus, jqXHR) {
                                        if (data === 'true') {
                                            $("#savedAlert").addClass('show sticky-top');
                                            setTimeout(function () {
                                                $("#savedAlert").removeClass('show sticky-top');
                                            }, 2000);
                                            $("#editNotesModal").modal('toggle');
                                            location.reload();
                                        }
                                        else {
                                            $("#errorEditSave").addClass('show');
                                            setTimeout(function () {
                                                $("#errorSave").removeClass('show');
                                            }, 2000);
                                        }
                                    }, error: function (jqXHR, textStatus, errorThrown) {
                                        $("#errorSave").addClass('show');
                                        setTimeout(function () {
                                            $("#errorSave").removeClass('show');
                                        }, 2000);
                                    }})
                                return false;
                            }

                            function handleSave(e) {
                                $.ajax({url: 'NoteHandler', type: 'POST', dataType: 'text/plain', data: $("#newNote").serialize(), success: function (data, textStatus, jqXHR) {
                                        console.log(data)
                                        if (data === 'true') {
                                            $("#savedAlert").addClass('show sticky-top');
                                            setTimeout(function () {
                                                $("#savedAlert").removeClass('show sticky-top');
                                            }, 2000);
                                            $("#addNotesModal").modal('toggle');
                                            location.reload();
                                        }
                                        else {
                                            $("#errorSave").addClass('show');
                                            setTimeout(function () {
                                                $("#errorSave").removeClass('show');
                                            }, 2000);
                                        }
                                    }, error: function (jqXHR, textStatus, errorThrown) {
                                        console.log(jqXHR)
                                        if (jqXHR.responseText === 'true') {
                                            $("#savedAlert").addClass('show sticky-top');
                                            setTimeout(function () {
                                                $("#savedAlert").removeClass('show sticky-top');
                                                location.reload();
                                            }, 2000);
                                            $("#addNotesModal").modal('toggle');
                                        }
                                        else {
                                            $("#errorSave").addClass('show');
                                            setTimeout(function () {
                                                $("#errorSave").removeClass('show');
                                            }, 2000);
                                        }
                                        $("#errorSave").addClass('show');
                                        setTimeout(function () {
                                            $("#errorSave").removeClass('show');
                                        }, 2000);
                                    }})
                                return false;
                            }
        </script>


    </body>
</html>
