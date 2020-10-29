<%@page contentType="text/html" pageEncoding="UTF-8" %>
<jsp:useBean id="pDAO" class="myPackage.DatabaseClass" scope="page"/>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="style-backend.css">
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
    <a href="HomeController?action=logout" class="button btn btn-danger"
       style="float: right;background:crimson;color:white;margin-right: 1rem"
    >Logout</a>

</div>

<%
    if (session.getAttribute("userStatus") != null) {
        if (session.getAttribute("userStatus").equals("1") && session.getAttribute("type").equals("1")) {

%>


<%
    if (request.getParameter("pgprt").equals("1")) {

%>

<jsp:include page="accounts.jsp"/>

<%

} else if (request.getParameter("pgprt").equals("2")) {

%>

<jsp:include page="courses.jsp"/>

<%

} else if (request.getParameter("pgprt").equals("3")) {
%>

<jsp:include page="questions.jsp"/>
<%
} else if (request.getParameter("pgprt").equals("4")) {
%>

<jsp:include page="showall.jsp"/>
<%
} else {
%>

<jsp:include page="profile.jsp"/>

<%
    }
%>

<%
        } else {

            response.sendRedirect("std-page.jsp?pgprt=0");
        }
    } else response.sendRedirect("login.jsp");
%>


</body>
</html>