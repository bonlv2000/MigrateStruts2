<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Models.classes.Exams" %>
<%@page import="Models.classes.Questions" %>
<%@page import="java.util.ArrayList" %>
<%@ page import="Models.classes.Courses" %>
<%@ page import="Models.DatabaseClass" %>
<jsp:useBean id="pDAO" class="Models.DatabaseClass" scope="page"/>
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
        left: 210px;
        top: -10px;
    }



    .close:hover,
    .close:focus {
        color: #000;
        text-decoration: none;
        cursor: pointer;
    }
</style>

<style>
    .content-area {
        display: block !important;
        margin-top: 4rem;
        margin-left: 20rem;
        padding: 20px;
        padding-left: 30px;
    }

    .question-label {
        height: 65px !important;
    }


</style>


<!-- CONTENT AREA -->
<div class="content-area">
    <% if (session.getAttribute("examStarted") != null) { %>
    <% }%>
    <%
        if (session.getAttribute("examStarted") != null) {
            if (session.getAttribute("examStarted").equals("1")) {
    %>
    <span id="remainingTime"
          style="position: fixed;top:90px;left: 300px;font-size: 23px;background: rgba(255,0,77,0.38);border-radius: 5px;padding: 10px;box-shadow: 2px -2px 6px 0px;">
        </span>
    <%
        int time = new DatabaseClass().getRemainingTime(Integer.parseInt(session.getAttribute("examId").toString()));
    %>
    <script>
        let time,sec;
        if(window.localStorage.getItem("time")==null || localStorage.getItem("examId")==null
            || localStorage.getItem("examId")!=<%=session.getAttribute("examId").toString()%>) {
            time = <%=time%>;
            sec = 0;
            window.localStorage.setItem("time",time);
            window.localStorage.setItem("sec",sec);
            localStorage.setItem("examId",<%=session.getAttribute("examId").toString()%>)
        }


        else {
            time = window.localStorage.getItem("time");
            sec = window.localStorage.getItem("sec");
        }



        document.getElementById("remainingTime").innerHTML = time + " : " + sec;
        let x = window.setInterval(timerFunction, 1000);

        function timerFunction() {
            sec--;
            window.localStorage.setItem("sec",sec);
            if (time < 0) {
                clearInterval(x);
                document.getElementById("remainingTime").innerHTML = "00 : 00";
                document.getElementById("myform").submit();
            }
            if (sec < 0) {
                sec = 59;
                time--;
                window.localStorage.setItem("time",time);
            }
            document.getElementById("remainingTime").innerHTML = time + " : " + sec;
        }
        <c:if test="${sessionScope.examStarted!=null}">
        window.onbeforeunload = function(e) {
            <%session.setAttribute("examStarted",null);%>
            return "Your test wil be failed";
        }

        </c:if>
        function validate() {
            if(!confirm("Do you really want to do this?")) {
                return false;
            }
            <%session.setAttribute("examStarted",null);%>
            this.form.submit();
        }
    </script>

    <form id="myform" onsubmit="return validate(this)" name="abc" action="exam.action" method="post">
        <%
            ArrayList<Questions> list = pDAO.getQuestions(request.getParameter("coursename"));
            Questions question;
        %>
        <input type="hidden" name="size" value="<%=list.size()%>">
        <input type="hidden" name="totalmarks"
               value="<%=pDAO.getTotalMarksByCode(request.getParameter("coursename"))%>">
        <%
            for (int i = 0; i < list.size(); i++) {
                question = list.get(i);
        %>
        <center>
            <div class="question-panel">
                <div class="question">
                    <label class="question-label"><%=i + 1 %>
                    </label>
                    <%=question.getQuestion() %>
                </div>
                <div class="answer">
                    <input type="radio" id="c1<%=i%>" name="ans<%=i%>" value="<%=question.getOpt1()%>"/>
                    <label for="c1<%=i%>"><%=question.getOpt1()%>
                    </label>
                    <input type="radio" id="c2<%=i%>" name="ans<%=i%>" value="<%=question.getOpt2()%>"/>
                    <label for="c2<%=i%>"><%=question.getOpt2()%>
                    </label>
                    <input type="radio" id="c3<%=i%>" name="ans<%=i%>" value="<%=question.getOpt3()%>"/>
                    <label for="c3<%=i%>"><%=question.getOpt3()%>
                    </label>
                    <input type="radio" id="c4<%=i%>" name="ans<%=i%>" value="<%=question.getOpt4()%>"/>
                    <label for="c4<%=i%>"><%=question.getOpt4()%>
                    </label>

                </div>
            </div>
            <input type="hidden" name="question<%=i%>" value="<%=question.getQuestion()%>">
            <input type="hidden" name="qid<%=i%>" value="<%=question.getQuestionId()%>">
                <%
                       }

                       %>

            <div id="SubmitExams" class="modal">
                <!-- Modal content -->
                <div style="margin-top: 90px;width: 32%;" class="modal-content">
                    <span class="close">&times;</span>

                        <h1 style="margin: auto">Submit Exams</h1>
                        <p style="margin: auto">Are you sure you want to Submit Exams?</p>
                        <div class="modal-footer">
                            <input type="hidden" name="action" value="submitted">
                            <input type="submit" class="add-btn" style="position: relative;right: 117px;" value="Finished"/>
                            <button type="button" style="position: relative;right: 101px;top: 9px;" class="alert alert-info" data-dismiss="modal" onclick="closeFormDelete()">
                                Close
                            </button>
                        </div>

                </div>

            </div>

            <a id="SubmitBtn" class="button" style="text-decoration: none!important;"><span class="add-btn" style="margin-left: 43px;background-color: white;color: black;border: 2px solid #1e1c1c;">Finished</span></a>
    </form>



    <%
        }
    } else if (request.getParameter("showresult") != null) {
        if (request.getParameter("showresult").equals("1")) {
            Exams result = new DatabaseClass().getResultByExamId(Integer.parseInt(request.getParameter("eId")));
    %>
    <div class="panel" style="float: left;max-width: 900px">
        <div class="title">Result of Recent Exam</div>
        <div class="profile">
            <span class="tag" style="font-size: 14px">Exam Date</span><span class="val"><%=result.getDate() %></span><br/>
            <span class="tag"style="font-size: 14px">Start Time</span><span class="val"><%=result.getStartTime() %></span><br/>
            <span class="tag"style="font-size: 14px">End Time</span><span class="val"><%=result.getEndTime() %></span><br/>
            <span class="tag"style="font-size: 14px">Course Name</span><span class="val"><%=result.getcName() %></span><br/>
            <span class="tag"style="font-size: 14px">Obt Marks</span><span class="val"><%=result.getObtMarks() %></span><br/>
            <span class="tag"style="font-size: 14px">Total Marks</span><span class="val"><%=result.gettMarks() %></span><br/>
            <span class="tag"style="font-size: 14px">Result</span><span class="val"><%=result.getStatus() %></span></h2>
        </div>
        <p></p>
        <p></p>
        <p></p>
        <p></p>
        <p></p>
    </div>
    <%
        }
    } else if (session.getAttribute("examStarted") == null) {
    %>
    <div class="panel form-style-6" style="float: left;max-width: 900px; padding-top: 40px;">
        <div class="title" style="margin-top: -60px;">Select Course to Take Exam</div>
        <br/>
        <form action="exam.action" method="post">
            <br/><br>
            <label>Select Course</label>
            <input type="hidden" name="action" value="startExam">
            <select name="coursename" class="text">
                <%
                    ArrayList<Courses> list1 = pDAO.getAllCourses();
                    for (int i = 0; i < list1.size(); i++) {
                %>
                <option value="<%=list1.get(i).getcCode()%>"><%=list1.get(i).getcName()%>
                </option>
                <%
                    }
                %>
            </select>
            <input type="submit" value="Take Exam" class="form-button">
        </form>
    </div>
    <%
        if(session.getAttribute("isDelete")!=null) {
            out.println("<script>var modal = document.getElementById(\"Delete\");" +
                    "modal.style.display = \"block\";</script>");
        }
    %>
    <% }%>
    <script>


        // Get the modal
        var modalExams = document.getElementById("SubmitExams");

        // Get the button that opens the modal
        var btnExams = document.getElementById("SubmitBtn");

        // Get the <span> element that closes the modal
        var spanExams = document.getElementsByClassName("close")[0];

        // When the user clicks the button, open the modal
        btnExams.onclick = function () {
            modalExams.style.display = "block";
        }

        // When the user clicks on <span> (x), close the modal
        spanExams.onclick = function () {
            modalExams.style.display = "none";
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modalExams) {
                modalExams.style.display = "none";
            }
        }

        function closeFormDelete() {
            modalExams.style.display = "none";
        }
    </script>
</div>
       