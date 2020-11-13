<%@ page import="java.util.ArrayList" %>
<%@ page import="Models.classes.Questions" %>
<%@ page import="Models.DatabaseClass" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="pDAO" class="Models.DatabaseClass"/>



<!-- SIDEBAR -->

<!-- CONTENT AREA -->
<%
    ArrayList<Questions> questions = pDAO.getQuestions(request.getParameter("coursename"));
    session.setAttribute("questions",questions);
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


<div style="padding: 1rem">
    <a href="adm-page.jsp?pgprt=3"><i class="fas fa-arrow-circle-left" style="color: #80350e;font-size: 2rem;">Go Back</i></a>
</div>
<div class="content-area">
    <%
        int totalPageResult = new DatabaseClass().totalQuestionByCourseCode(request.getParameter("coursename"));
        session.setAttribute("courseName",request.getParameter("coursename"));
        session.setAttribute("totalPageResult",totalPageResult);
    %>
    <center>
        <c:if test="${sessionScope.pagingItems.size()>0 or sessionScope.pagingItems!=null}">
            <c:forEach items="${sessionScope.pagingItems}" var="item">
                <div class="question-panel">
                    <div style="width: 190%;left: 200px;" class="question">
                        <label style="height: 65px !important;" class="question-label">${items + 1}
                        </label>
                            ${item.question}

                        <a href="updateQuestion?action=updateGet&qid=${item.questionId}&coursename=<%=
                request.getParameter("coursename")%>"
                           type="submit">
                            <div class="btn btn-primary" id="myBtn" style="position: absolute;right: 103px;top: -20px;padding: 10px;">Update</div>
                        </a>



                        <a href="deleteQuestion?action=deleteGet&qid=${item.questionId}&coursename=<%=
                request.getParameter("coursename")%>"
                        >
                            <div class="delete-btn" id="DeleteBtn" style="position: absolute;right: 10px;top: -20px;">delete</div>
                        </a>
                    </div>
                    <div style="width: 190%;left: 200px;" class="answer">
                        <label class="show">${item.opt1}</label>
                        <label class="show">${item.opt2}
                        </label>
                        <label class="show">${item.opt3}
                        </label>
                        <label class="show">${item.opt4}
                        </label>
                        <label class="show-correct">${item.correct}
                        </label>
                    </div>
                </div>
            </c:forEach>
            <nav aria-label="Page navigation example" style="margin:1rem 45%">
                <ul class="pagination" style="padding: 1rem">
                    <c:forEach begin="1" end="${sessionScope.totalPageResult}" var="i">
                        <c:if test="${sessionScope.index.equals(i)}">
                            <li class="page-item active"><a class="page-link" href="paging.action?action=question&coursename=<%=request.getParameter("coursename")%>&index=${i}>">${i}</a></li>
                        </c:if>
                        <c:if test="${!sessionScope.index.equals(i)}">
                            <li class="page-item"><a class="page-link" href="paging.action?action=question&index=${i}&coursename=<%=request.getParameter("coursename")%>">${i}</a></li>
                        </c:if>
                    </c:forEach>
                </ul>
            </nav>
        </c:if>
        <c:if test="${sessionScope.pagingItems.size()==0 or sessionScope.pagingItems==null}">
            <h3 style="text-align: center">This course doesn't have any question</h3>
        </c:if>

        <div id="myModal" class="modal">

            <!-- Modal content -->
            <div class="modal-content">
                <span class="close">&times;</span>
                <form action="updateQuestion.action" method="POST">
                    <div class="modal-body">
                        <h2>Update Info</h2>
                        <input type="hidden" name="qid" id="edit_qid" value="${sessionScope.questionUpdate.questionId}">
                        <input type="hidden" name="coursename" id="edit_coursename" value="${sessionScope.questionUpdate.courseName}">
                        <div class="form-group">
                            <label>Question Name</label>
                            <input type="text" name="question" id="edit_question" class="form-control"
                                   value="${sessionScope.questionUpdate.question}">
                        </div>
                        <div class="form-group">
                            <label>Opt1</label>
                            <input type="text" name="opt1" id="edit_fopt1" class="form-control"
                                   value="${sessionScope.questionUpdate.opt1}">
                        </div>
                        <div class="form-group">
                            <label>Opt2</label>
                            <input type="text" name="opt2" id="edit_fopt2" class="form-control"
                                   value="${sessionScope.questionUpdate.opt2}">
                        </div>
                        <div class="form-group">
                            <label>Opt3</label>
                            <input type="text" name="opt3" id="edit_fopt3" class="form-control"
                                   value="${sessionScope.questionUpdate.opt3}">
                        </div>
                        <div class="form-group">
                            <label>Opt4</label>
                            <input type="text" name="opt4" id="edit_fopt4" class="form-control"
                                   value="${sessionScope.questionUpdate.opt4}">
                        </div>
                        <div class="form-group">
                            <label>Correct</label>
                            <input type="text" name="correct" id="edit_fcorrect" class="form-control"
                                   value="${sessionScope.questionUpdate.correct}">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="closeForm()">
                            Close
                        </button>
                        <input type="hidden" name="action" value="update">
                        <input type="submit" name="update_question" class="btn btn-primary" value="Update">
                    </div>
                </form>

            </div>


        </div>

        <div id="Delete" class="modal">
            <!-- Modal content -->
            <div style="margin-top: 90px;width: 32%;" class="modal-content">
                <span class="closeDelete">&times;</span>
                <form action="deleteQuestion.action" method="POST">
                    <h1 style="margin: auto;">Delete Account</h1>
                    <p style="margin: auto;">Are you sure you want to delete your account?</p>
                    <input type="hidden" name="qid" id="edit_uid" value="${sessionScope.questionDelete.questionId}">
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
                    session.removeAttribute("questionUpdate");
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
                    session.removeAttribute("questionDelete");
                %>
            }
        </script>

    </center>
</div>