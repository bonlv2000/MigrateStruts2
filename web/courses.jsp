<%@page import="java.util.ArrayList" %>
<%@ page import="Models.classes.Courses" %>
<%@ page import="Models.DatabaseClass" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="pDAO" class="Models.DatabaseClass" scope="page"/>
<%
    if(session.getAttribute("name")==null)
        response.sendRedirect("home?action=login");
    else {
        if(!session.getAttribute("type").toString().equals("1")) {
            response.sendRedirect("loginGet");
        }
    }

    if(session.getAttribute("courseUpdate")==null) {
        session.removeAttribute("isUpdate");
    }
%>
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
    int totalPage = new DatabaseClass().totalPageCourse(session.getAttribute("query").toString());
    session.setAttribute("totalPageResult",totalPage);
%>

<div class="panel" style="max-width: 640px;float:right;right: 30%;">
    <div class="title">
        All Courses
    </div>
    <a id="myBtnReg" class="button" style="text-decoration: none!important;"><span class="add-btn" style="margin-left: 80px;margin-left: 43px;">Add New Course</span></a>
    <form method="get" action="paging" class="container" style="margin-top: 1rem">
        <input type="hidden" name="action" value="course">
        <div class="row justify-content-center">
            <div class="form-group col-4 " style="display: flex">
                <input name="query" type="text" style="width: 200px" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp"
                       placeholder="Search by course name">
                <input class="btn btn-info" type="submit" value="Search">
            </div>

        </div>

    </form>
    <table id="one-column-emphasis" style="min-width: 400px;margin: 5px; margin-top: 35px">
        <colgroup>
            <col class="oce-first"/>
        </colgroup>
        <thead>
        <tr>
            <th scope="col">Course Code</th>
            <th scope="col">Courses</th>
            <th scope="col">T.Marks</th>
            <th scope="col">Time</th>
            <th scope="col">Update</th>
            <th scope="col">Action</th>

        </tr>
        </thead>

        <c:forEach var="item" items="${sessionScope.pagingItems}">

            <tr>
                <td style="padding: 12px 15px;">${item.cCode}</td>
                <td style="padding: 12px 15px;">${item.cName}</td>
                <td style="padding: 12px 15px;">${item.tMarks}</td>
                <td style="padding: 12px 15px;">${item.time}</td>
                <td style="padding: 20px 15px;">
                    <a href="updateCourse?action=updateGet&courseCode=${item.cCode}"
                       type="submit" class="btn btn-primary" id="myBtn"><i class="fas fa-edit"></i>
                    </a>
                </td>
                <td style="padding: 12px 15px;">
                    <a href="deleteCourse?action=deleteGet&courseCode=${item.cCode}"
                       type="submit" class="btn btn-danger"
                       id="DeleteBtn"><i class="fas fa-trash-alt"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>

        <div id="myModal" class="modal" style="z-index: 2">

            <!-- Modal content -->
            <div class="modal-content">
                <span class="close">&times;</span>
                <form action="updateCourse.action" method="POST">
                    <div class="modal-body">
                        <h2>Update Info</h2>
                        <input type="hidden" name="courseCode" id="edit_courseid" value="${sessionScope.courseUpdate.cCode}">
                        <div class="form-group">
                            <label>Courses</label>
                            <input type="text" name="coursename" id="edit_coursefname" class="form-control"
                                   value="${sessionScope.courseUpdate==null ? "":sessionScope.courseUpdate.cName}">
                        </div>
                        <div class="form-group">
                            <label>T.Marks</label>
                            <input type="text" name="totalmarks" id="edit_coursemark" class="form-control"
                                   value="${sessionScope.courseUpdate==null ? "":sessionScope.courseUpdate.tMarks}">
                        </div>
                        <div class="form-group">
                            <label>Time</label>
                            <input type="text" name="time" id="edit_coursetime" class="form-control"
                                   value="${sessionScope.courseUpdate==null ? "":sessionScope.courseUpdate.time}">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="closeForm()">
                            Close
                        </button>
                        <input type="hidden" name="action" value="update">
                        <input type="submit" name="update_course" class="btn btn-primary" value="Update">
                    </div>
                </form>
            </div>

        </div>


    </table>
    <nav aria-label="Page navigation example" style="margin-left: 10rem; margin-top: 2rem">
        <ul class="pagination">
            <c:forEach begin="1" end="${sessionScope.totalPageResult}" var="i">
                <c:if test="${sessionScope.index.equals(i)}">
                    <li class="page-item active"><a class="page-link" href="paging?action=course&index=${i}&query=${sessionScope.query}">${i}</a></li>
                </c:if>
                <c:if test="${!sessionScope.index.equals(i)}">
                    <li class="page-item"><a class="page-link" href="paging?action=course&index=${i}&query=${sessionScope.query}">${i}</a></li>
                </c:if>
            </c:forEach>
        </ul>
    </nav>
</div>

<!-- The Modal -->
<div id="myModalReg" class="modal">

    <!-- Modal content -->

    <div class="panel form-style-6" style="right:5%;max-width: 450px">

        <div class="title">
            Add New Course
        </div>

        <span style="position: relative;left: 190px;font-size: 20px;" class="closeReg">x</span>
        <center>
            <form action="course.action" method="post">
                <br>
                <table>
                    <tr>
                        <td><label>Course Code</label></td>
                        <td><input type="text" name="courseCode" class="text" placeholder="Course Code"
                                   style="width: 230px;"></td>
                    </tr>
                    <tr>
                        <td><label>Course Name</label></td>
                        <td><input type="text" name="coursename" class="text" placeholder="Course Name"
                                   style="width: 230px;"></td>
                    </tr>
                    <tr>
                        <td><label>Total Marks</label></td>
                        <td><input type="text" name="totalmarks" class="text" placeholder="Total Marks"
                                   style="width: 230px;"></td>
                    </tr>
                    <tr>
                        <td><label>Exam Time</label></td>
                        <td>
                            <input type="text" name="time" class="text" placeholder="MM" style="width: 230px;">
                        </td>

                    </tr>
                    <tr>
                        <td colspan="2"><input type="hidden" name="page" value="courses">
                            <input type="hidden" name="action" value="add">
                            <center><input type="submit" class="form-button" value="Add" name="submit"></center>
                        </td>
                    </tr>
                </table>

            </form>
        </center>

    </div>

</div>

<div id="Delete" class="modal">
    <!-- Modal content -->
    <div style="margin-top: 90px;width: 32%;" class="modal-content">
        <span class="closeDelete">&times;</span>
        <form action="deleteCourse.action" method="POST">
            <h1 style="margin: auto;padding-left: 83px;">Delete Account</h1>
            <p style="margin: auto;padding-left: 60px;">Are you sure you want to delete your account?</p>
            <input type="hidden" name="courseCode" id="edit_courseCode" value="${sessionScope.courseDelete.cCode}">
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

<%
    if(session.getAttribute("isDelete")!=null) {
        out.println("<script>var modal = document.getElementById(\"Delete\");" +
                "modal.style.display = \"block\";</script>");
    }
%>

<%
    if(session.getAttribute("isUpdate")!=null) {
        out.println("<script>var modal = document.getElementById(\"myModal\");" +
                "modal.style.display = \"block\";</script>");
    }
%>
<script>


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
//                    session.removeAttribute("courseUpdate");
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
</div>
</div>

                       