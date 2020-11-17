<%@page import="java.util.ArrayList" %>
<%@ page import="Models.classes.User" %>
<%@ page import="Models.DatabaseClass" %>
<%@ page import="java.util.stream.Collectors" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    if(session.getAttribute("name")==null)
        response.sendRedirect("home?action=login");
    else {
        if(!session.getAttribute("type").toString().equals("1")) {
            response.sendRedirect("loginGet");
        }
    }
%>
<%

    User user = new DatabaseClass().getUserDetails(session.getAttribute("userId").toString());
    if (user.getType().endsWith("admin")) {
%>
<!-- SIDEBAR -->

<link rel="stylesheet" href="Common/test/css/styleAccount.css">
<link rel="stylesheet" href="Common/test/fonts/font-awesome-4.7.0/css/font-awesome.css">
<style>


    /* The Modal (background) */
    .modal {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1; /* Sit on top */
        padding-top: 100px; /* Location of the box */
        left: 163px;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgb(0, 0, 0); /* Fallback color */
        background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
    }

    /* Modal Content */
    .modal-content {
        background-color: #fefefe;
        margin: auto;
        padding: 20px;
        border: 1px solid #888;
        width: 50%;
    }

    /* The Close Button */
    .close {
        color: #aaaaaa;

        font-size: 28px;
        float: right;
        font-weight: bold;
        position: relative;
        left: 688px;
        top: -10px;
    }

    .close:hover,
    .close:focus {
        color: #000;
        text-decoration: none;
        cursor: pointer;
    }
</style>
<%
    int totalPageResult = new DatabaseClass().totalPageAccount(session.getAttribute("query").toString());
    session.setAttribute("totalPageResult",totalPageResult);
%>
<div class="inner" style="margin-top: 50px;background-color: whitesmoke!important;width: 1100px;margin-left: 100px;">
    <div class="title" style="margin-top: -30px; height: 60px!important;">List of All Registered Persons</div>
    <a id="myBtnReg" class="button" style="text-decoration: none!important;"><span class="add-btn" style="margin-left: 80px;">Add New Person</span></a>
    <form method="get" action="paging" class="container" style="margin-top: 1rem">
        <input type="hidden" name="action" value="account">
        <div class="row justify-content-center">
            <div class="form-group col-4" style="display: flex">
                <input name="query" type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp"
                       placeholder="Search by username">
                <input class="btn btn-info" type="submit" value="Search">
            </div>
        </div>
    </form>
    <br>

    <table id="one-column-emphasis" style="margin-top: 10px">
        <colgroup>
            <col class="oce-first"/>
        </colgroup>
        <thead>
        <tr>
            <th scope="col">User Name</th>
            <th scope="col">First Name</th>
            <th scope="col">Last Name</th>
            <th scope="col">Email</th>
            <th scope="col">Roles</th>
            <th scope="col">Update</th>
            <th scope="col">Delete</th>

        </tr>
        </thead>
        <tbody>


        <c:forEach var="item" items="${sessionScope.pagingItems}">
            <tr>
                <td style="padding: 12px 15px;">${item.userName}</td>
                <td style="padding: 12px 15px;">${item.firstName}</td>
                <td style="padding: 12px 15px;">${item.lastName}</td>
                <td style="padding: 12px 15px;">${item.email}</td>
                <td style="padding: 12px 15px;">${item.type}</td>
                <td style="padding: 20px 15px;">
                    <a href="updateUser?action=updateGet&userId=${item.userId}"
                       type="submit" class="btn btn-primary" id="myBtn"><i class="fas fa-edit"></i>
                    </a>

                </td>
                <td style="padding: 12px 15px;">
                    <a href="DeleteUser?action=deleteGet&userId=${item.userId}"
                       type="submit" class="btn btn-danger"
                       id="DeleteBtn"><i class="fas fa-trash-alt"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <nav aria-label="Page navigation example" style="margin:1rem 45%">
        <ul class="pagination" style="padding: 1rem">
            <c:forEach begin="1" end="${sessionScope.totalPageResult}" var="i">
                <c:if test="${sessionScope.index.equals(i)}">
                    <li class="page-item active"><a class="page-link" href="paging.action?action=account&index=${i}&query=${sessionScope.query}">${i}</a></li>
                </c:if>
                <c:if test="${!sessionScope.index.equals(i)}">
                    <li class="page-item"><a class="page-link" href="paging.action?action=account&index=${i}&query=${sessionScope.query}">${i}</a></li>
                </c:if>
            </c:forEach>
        </ul>
    </nav>
    <script>

    </script>
    <div id="myModal" class="modal">
        <!-- Modal content -->
        <div class="modal-content">
            <span class="close">&times;</span>
            <form action="updateUser.action" method="POST" id="formAccount">
                <input type="hidden" name="userName" value="${sessionScope.userUpdate.userName}">
                <input type="hidden" name="query" value=<%=request.getParameter("query")%>>
                <input type="hidden" name="index" value=<%=request.getParameter("index")%>>
                <div class="modal-body">
                    <h2>Update Info</h2>
                    <input type="hidden" name="userId" id="edit_id" value="${sessionScope.userUpdate.userId}">
                    <div class="form-group">
                        <label>First Name</label>
                        <input type="text" name="firstName" id="edit_fname" class="form-control"
                               value="${sessionScope.userUpdate==null ? "":sessionScope.userUpdate.firstName}">
                    </div>
                    <div class="form-group">
                        <label>Last Name</label>
                        <input type="text" name="lastName" id="edit_lname" class="form-control"
                               value="${sessionScope.userUpdate==null ? "":sessionScope.userUpdate.lastName}">
                    </div>
                    <div class="form-group emailValidate" id="form-email">
                        <s:fielderror fieldName="emailValidation" style="color:red"></s:fielderror>
                        <label>Email</label>
                        <input type="text" name="email" id="edit_class" class="form-control"
                               value="${sessionScope.userUpdate==null ? "":sessionScope.userUpdate.email}">
                    </div>
                    <div class="form-group">
                        <label>Pass</label>
                        <input type="password" name="password" id="edit_password" class="form-control"
                               value="${sessionScope.userUpdate==null ? "":sessionScope.userUpdate.password}" >
                        <i class="far fa-eye" style="position: relative;left: 95%;bottom: 30px;" id="togglePassword" onClick="hideAndShow()"></i>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="closeForm()">
                        Close
                    </button>
                    <input type="hidden" name="action" value="update">
                    <input type="submit" name="update_student" class="btn btn-primary" value="Update">
                </div>
            </form>
        </div>

    </div>


    <div id="Delete" class="modal">
        <!-- Modal content -->
        <div style="margin-top: 90px;width: 32%;" class="modal-content">
            <span class="closeDelete">&times;</span>
            <form action="DeleteUser.action" method="POST">
                <h1 style="margin: auto;">Delete Account</h1>
                <p style="margin: auto;">Are you sure you want to delete your account?</p>
                <input type="hidden" name="userId" id="edit_uid" value="${sessionScope.userDelete.userId}">
                <div class="modal-footer">
                    <input type="hidden" name="action" value="delete">
                    <input type="submit" style="position: relative;right:130px;" name="Delete_student" class="alert alert-danger" value="Delete">
                    <button type="button" style="position: relative;right: 130px;" class="alert alert-info" data-dismiss="modal" onclick="closeFormDelete()">
                        Close
                    </button>
                </div>
            </form>
        </div>

    </div>

    <div id="myModalReg" class="modal">
        <!-- Modal content -->
        <div class="modal-content">
            <span class="closeReg">&times;</span>
            <form action="addUserFromAdmin.action" method="POST" >
                <div class="modal-body">
                    <h2>Add Account</h2>

                    <div class="form-group">
                        <label>First Name</label>
                        <input type="text" class="form-control" name="firstName" id="fname" placeholder="First Name"/>
                    </div>
                    <div class="form-group">
                        <label>Last Name</label>
                        <input type="text" class="form-control" name="lastName" id="lname" placeholder="Last Name"/>
                    </div>
                    <div class="form-group" id="form_add_username">
                        <label>User Name</label>
                        <input type="text" class="form-control" name="userName" id="uname" placeholder="User Name"/>
                    </div>
                    <div class="form-group" id="form_add_email">
                        <label>Your Email</label>
                        <input type="email" class="form-control" name="email" id="email" placeholder="Your Email"/>
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" class="form-control" name="pass" id="password" placeholder="Password"/>

                        <span toggle="#password" class="zmdi zmdi-eye field-icon toggle-password"></span>
                        <i class="far fa-eye" style="position: relative;left: 95%;bottom: 30px;" id="togglePasswordReg" onClick="hideAndShowReg()"></i>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="closeFormReg()">
                        Close
                    </button>
                    <input type="hidden" name="action" value="addFromAdmin">
                    <input type="submit" style="cursor: pointer;" name="submit" id="submit" class="btn btn-primary" value="Sign up"/>
                </div>
            </form>
        </div>
    </div>
    <%
        if(session.getAttribute("isDelete")!=null) {
            out.println("<script>var modal = document.getElementById(\"Delete\");" +
                    "modal.style.display = \"block\";</script>");
        }

        if(session.getAttribute("isAdding")!=null) {
            out.println("<script>var modal = document.getElementById(\"myModalReg\");" +
                    "modal.style.display = \"block\";</script>");
        }
    %>


    <%
            if (session.getAttribute("isUpdate") != null) {
                out.println("<script>var modal = document.getElementById(\"myModal\");" +
                        "modal.style.display = \"block\";</script>");
            }
        %>
        <script>

            if($("#form-email").find(".emailHere").length>0) {
                $(".emailHere").remove();
            }
            if(${sessionScope.contentEmailValidate!=null}) {
                $('#form-email').append("<p class='emailHere' style='color: red'>Update Email is already exist</p>");
            }


            if($("#form_add_email").find(".emailHere").length>0) {
                $(".emailHere").remove();
            }
            if(${sessionScope.contentEmailValidate!=null}) {
                $('#form_add_email').append("<p class='emailHere' style='color: red'>Email is already exist</p>");
            }
            if($("#form_add_username").find(".emailHere").length>0) {
                $(".emailHere").remove();
            }
            if(${sessionScope.contentEmailValidate!=null}) {
                $('#form-email').append("<p class='emailHere' style='color: red'>Update Email is already exist</p>");
            }
            // Get the modal
            var modal = document.getElementById("myModal");

            // Get the button that opens the modal
            var btn = document.getElementById("myBtn");

            // Get the <span> element that closes the modal
            var span = document.getElementsByClassName("close")[0];

            // When the user clicks the button, open the modal
            btn.onclick = function () {
                modal.style.display = "block";
            }

            // When the user clicks on <span> (x), close the modal
            span.onclick = function () {
                modal.style.display = "none";
            }

            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function (event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
            function closeForm() {
                modal.style.display = "none";
                <%
                    session.removeAttribute("isUpdate");
//                        session.removeAttribute("userUpdate");
                %>
            }
        </script>

    <script>


        // Get the modal
        var modalDelete = document.getElementById("Delete");

        // Get the button that opens the modal
        var btnDelete = document.getElementById("DeleteBtn");

        // Get the <span> element that closes the modal
        var spanDelete = document.getElementsByClassName("closeDelete")[0];

        // When the user clicks the button, open the modal
        btnDelete.onclick = function () {
            modalDelete.style.display = "block";
        }

        // When the user clicks on <span> (x), close the modal
        spanDelete.onclick = function () {
            modalDelete.style.display = "none";
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modalDelete) {
                modalDelete.style.display = "none";
            }
        }

        function closeFormDelete() {
            modalDelete.style.display = "none";
            <%
                session.removeAttribute("isDelete");
//                        session.removeAttribute("userUpdate");
            %>
        }
    </script>
    <script>


        // Get the modal
        var modalReg = document.getElementById("myModalReg");

        // Get the button that opens the modal
        var btnReg = document.getElementById("myBtnReg");

        // Get the <span> element that closes the modal
        var spanReg = document.getElementsByClassName("closeReg")[0];

        // When the user clicks the button, open the modal
        btnReg.onclick = function () {
            modalReg.style.display = "block";
        }

        // When the user clicks on <span> (x), close the modal
        spanReg.onclick = function () {
            modalReg.style.display = "none";
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modalReg) {
                modalReg.style.display = "none";
            }
        }

        function closeFormReg() {
            modalReg.style.display = "none";
            <%session.removeAttribute("isAdding");%>
        }


    </script>


    <script>
        function hideAndShow(){
            var vip = document.querySelectorAll("input[id=edit_password]")[0].type;
            if (vip.includes("password")) {
                document.querySelectorAll("input[id=edit_password]")[0].type = "text";
                document.querySelectorAll("i[id=togglePassword]")[0].className = "fas fa-eye-slash";
            } else {
                document.querySelectorAll("input[id=edit_password]")[0].type = "password";
                document.querySelectorAll("i[id=togglePassword]")[0].className = "far fa-eye";
            }

        };



    </script>

    <script>
        function hideAndShowReg(){
            var vip = document.querySelectorAll("input[id=password]")[0].type;
            if (vip.includes("password")) {
                document.querySelectorAll("input[id=password]")[0].type = "text";
                document.querySelectorAll("i[id=togglePasswordReg]")[0].className = "fas fa-eye-slash";
            } else {
                document.querySelectorAll("input[id=password]")[0].type = "password";
                document.querySelectorAll("i[id=togglePasswordReg]")[0].className = "far fa-eye";
            }

        };



    </script>


        <script src="Common/test/js/ShowpassAndHide.js"></script>


        <!-- and so on... -->
        </tbody>
    </table>

</div>


<%
    }

%>

</div>
<%--</div>--%>