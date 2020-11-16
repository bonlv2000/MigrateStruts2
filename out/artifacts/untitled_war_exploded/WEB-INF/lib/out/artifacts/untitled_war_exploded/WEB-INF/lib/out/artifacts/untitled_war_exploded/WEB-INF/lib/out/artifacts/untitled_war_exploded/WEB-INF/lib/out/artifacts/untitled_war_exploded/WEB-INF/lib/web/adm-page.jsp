<%@ page import="Models.DatabaseClass" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responsive Sidebar Dashboard Template</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="Common/Manual/style-backend.css">
    <link rel="stylesheet" href="/Common/login/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>

<input type="checkbox" id="check">
<!--header area start-->
<header style="height: 80px">
    <label for="check">
        <i class="fas fa-bars" id="sidebar_btn"></i>    </label>
    <div class="left_area">
        <h3>Admin <span>Panel</span></h3>
    </div>
    <div class="right_area">
        <a href="home?action=logout" style="padding: 1rem; font-size: 1.2rem;" class="logout_btn">Log Out</a>
    </div>
    <div class="right_area">
<%--        <a href="home?action=home" style="padding: 1rem; font-size: 1.2rem;background-color: #238052" --%>
<%--           class="logout_btn">Back To HomePage</a>--%>
        <div class="dropdown" style="margin-left: 80rem">
            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Dropdown button
            </button>
            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <a class="dropdown-item" href="#">Action</a>
                <a class="dropdown-item" href="#">Another action</a>
                <a class="dropdown-item" href="#">Something else here</a>
            </div>
        </div>
    </div>



</header>
<!--header area end-->
<!--mobile navigation bar start-->
<div class="mobile_nav">
    <div class="nav_bar">
        <i class="fa fa-bars nav_btn"></i>
    </div>
    <div class="mobile_nav_items">
        <a href="adm-page.jsp?pgprt=0"><i class="fas fa-id-card-alt"></i><span>Profile</span></a>
        <a href="paging?action=course"><i class="fas fa-book"></i><span>Courses</span></a>
        <a href="adm-page.jsp?pgprt=3"><i class="far fa-question-circle"></i><span>Questions</span></a>
        <a href="paging?action=account"><i class="fas fa-users"></i><span>Accounts</span></a>
    </div>
</div>
<!--mobile navigation bar end-->
<!--sidebar start-->
<div class="sidebar" style="margin-top: 80px">
    <div class="profile_info">
        <h4><%=session.getAttribute("name")%></h4>
    </div>
    <a href="adm-page.jsp?pgprt=0"><i class="fas fa-id-card-alt"></i><span>Profile</span></a>
    <a href="paging?action=course"><i class="fas fa-book"></i><span>Courses</span></a>
    <a href="adm-page.jsp?pgprt=3"><i class="far fa-question-circle"></i><span>Questions</span></a>
    <a href="paging?action=account"><i class="fas fa-users"></i><span>Accounts</span></a>
</div>
<!--sidebar end-->
<script>

</script>

<div class="content" style="background-color: ghostwhite">

<div style="display: flex;flex-wrap: wrap;margin: 4rem auto;margin-bottom: 0rem; text-align: center" >
    <div class="card" style="width: 18rem;margin-left: 1rem">
        <div class="card-body">
            <h5 class="card-title">Account</h5><i class="fas fa-users"></i>
            <p class="card-text" style="font-size: 3rem; padding: 0"><%=new DatabaseClass().getAllUsers().size()%></p>
        </div>
    </div>
    <div class="card" style="width: 18rem;margin-left: 1rem">
        <div class="card-body">
            <h5 class="card-title">Courses</h5><i class="fas fa-book-open"></i>
            <p class="card-text" style="font-size: 3rem; padding: 0"><%=new DatabaseClass().getAllCourses().size()%></p>
        </div>
    </div>
    <div class="card" style="width: 18rem;margin-left: 1rem">
        <div class="card-body">
            <h5 class="card-title">Questions</h5><i class="fas fa-question"></i>
            <p class="card-text" style="font-size: 3rem; padding: 0"><%=new DatabaseClass().getAllQuestions().size()%></p>
        </div>
    </div>
    <div class="card" style="width: 18rem;margin-left: 1rem">
        <div class="card-body">
            <h5 class="card-title">Exams Took</h5><i class="fas fa-broom"></i>
            <p class="card-text" style="font-size: 3rem; padding: 0"><%=new DatabaseClass().getAllResults().size()%></p>
        </div>
    </div>
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
        session.setAttribute("courseName",request.getParameter("coursename"));
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
</div>

<script type="text/javascript">
    $(document).ready(function(){
        $('.nav_btn').click(function(){
            $('.mobile_nav_items').toggleClass('.active');
        });
    });
</script>
<!-- plugins:js -->
<script src="Common/Admin/vendors/base/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page-->
<script src="Common/Admin/vendors/chart.js/Chart.min.js"></script>
<!-- End plugin js for this page-->
<!-- inject:js -->
<script src="Common/Admin/js/off-canvas.js"></script>
<script src="Common/Admin/js/hoverable-collapse.js"></script>
<script src="Common/Admin/js/template.js"></script>
<script src="Common/Admin/js/todolist.js"></script>
<!-- endinject -->
<!-- Custom js for this page-->
<script src="Common/Admin/js/dashboard.js"></script>
<!-- End custom js for this page-->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>
