<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="pDAO" class="myPackage.DatabaseClass" scope="page"/>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="Common/Manual/style-backend.css">
    <link rel="stylesheet" href="/Common/login/css/bootstrap.min.css" type="text/css">
    <style>
        body {
            background-color: whitesmoke;
        }

        .title {
            height: 60px;
        }

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
</head>
<body>
<div class="top-area">
    <<h2 class="text-center text-dark">Admin Panel</h2>
    <a href="home?action=logout" class="button btn btn-danger"
       style="float: right;background:crimson;color:white;margin-right: 1rem"
    >Logout</a>

</div>
<div class="sidebar" style="background-image: url(Common/Manual/sidebar-1.jpg)">
    <div class="sidebar-background">
        <h2 class="logo-text">
            Online Examination System
        </h2>

        <div class="left-menu">
            <a href="adm-page.jsp?pgprt=0"><h2>Profile</h2></a>
            <a href="adm-page.jsp?pgprt=2"><h2>Courses</h2></a>
            <a class="active" href="adm-page.jsp?pgprt=3"><h2>Questions</h2></a>
            <a href="adm-page.jsp?pgprt=1"><h2>Accounts</h2></a>
        </div>
    </div>
</div>
<!-- CONTENT AREA -->
<div class="content-area">
    <center>
        <c:if test="${sessionScope.questions.size()>0}">
            <c:forEach items="${sessionScope.questions}" var="item">
                <div class="question-panel">
                    <div class="question">
                            ${item.question}
                        <a href="question?action=delete&qid=${item.questionId}"
                           onclick="return confirm('Are you sure you want to delete this ?');">
                            <div class="delete-btn" style="position: absolute;right: 10px;top: -20px;">delete</div>
                        </a>
                    </div>
                    <div class="answer">
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
        </c:if>
        <c:if test="${sessionScope.questions.size()==0}">
            <h3>This course don't have any question</h3>
        </c:if>
    </center>
</div>

</body>
</html>
