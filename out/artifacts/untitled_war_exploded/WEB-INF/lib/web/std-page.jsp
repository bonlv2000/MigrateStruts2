<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responsive Sidebar Dashboard Template</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="Common/Manual/style-backend.css">
<%--    <link rel="stylesheet" type="text/css" href="Common/Manual/style-front.css">--%>
<%--    <link rel="stylesheet" type="text/css" href="Common/Manual/style.css">--%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

</head>
<body>


<input type="checkbox" id="check">
<!--header area start-->
<header style="height: 80px">
    <label for="check">
        <i class="fas fa-bars" id="sidebar_btn"></i>
    </label>
    <div class="left_area">
        <h3>Student <span>Panel</span></h3>
    </div>
    <div class="right_area">
        <a href="home?action=logout" style="padding: 1rem; font-size: 1.2rem;" class="logout_btn">Log Out</a>
    </div>
    <div class="right_area">
        <a href="home?action=home" style="padding: 1rem; font-size: 1.2rem;background-color: #238052"
           class="logout_btn">Back To HomePage</a>
    </div>
</header>
<!--header area end-->
<!--mobile navigation bar start-->
<div class="mobile_nav">
    <div class="nav_bar">
        <i class="fa fa-bars nav_btn"></i>
    </div>
    <div class="mobile_nav_items">
        <a href="std-page.jsp?pgprt=0"><i class="fas fa-id-card-alt"></i><span>Profile</span></a>
        <a href="std-page.jsp?pgprt=1"><i class="fas fa-book"></i><span>Exams</span></a>
        <a href="pagingUser?action=result"><i class="fas fa-poll-h"></i><span>Result</span></a>
    </div>
</div>
<!--mobile navigation bar end-->
<!--sidebar start-->
<div class="sidebar" style="margin-top: 80px">
    <div class="profile_info">
        <h4><%=session.getAttribute("name")%></h4>
    </div>
    <a href="std-page.jsp?pgprt=0"><i class="fas fa-id-card-alt"></i><span>Profile</span></a>
    <a href="std-page.jsp?pgprt=1"><i class="fas fa-book"></i><span>Exams</span></a>
    <a href="pagingUser?action=result"><i class="fas fa-poll-h"></i><span>Result</span></a>



</div>
<!--sidebar end-->

<div class="content" style="background-color: ghostwhite">


    <%
        if(session.getAttribute("userStatus")!=null){
            if(session.getAttribute("userStatus").equals("1") && session.getAttribute("type").equals("0")){
    %>


    <%
        //pgpart = pagepart, exams=1,results=2 and profile is default
        if(request.getParameter("pgprt").equals("1")){

    %>

    <jsp:include page="exam.jsp"/>

    <%

    }else if(request.getParameter("pgprt").equals("2")){

    %>

    <jsp:include page="results.jsp"/>

    <%

    }else{
    %>
    <jsp:include page="profile.jsp"/>
    <%
        }
    %>
    <%
            }else response.sendRedirect("adm-page.jsp?pgprt=0");
        }else response.sendRedirect("login.jsp");
    %>
</div>
<script type="text/javascript">
    $(document).ready(function(){
        $('.nav_btn').click(function(){
            $('.mobile_nav_items').toggleClass('.active');
        });
    });
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>

