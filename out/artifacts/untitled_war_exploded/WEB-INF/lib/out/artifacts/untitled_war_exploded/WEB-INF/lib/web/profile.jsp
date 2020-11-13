<%@page import="Models.classes.User" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="pDAO" class="Models.DatabaseClass" scope="page"/>

<%
    User user = pDAO.getUserDetails(session.getAttribute("userId").toString());
    if (user.getType().endsWith("admin")) {
%>
<div class="content-area">
    <div class="panel" style="float: left;max-width: 600px">


            <%
           }else{
               %>

        <!-- SIDEBAR -->

        <!-- CONTENT AREA -->
        <div class="content-area">
            <div class="panel" style="float: left;max-width: 600px">
                <%
                    }
                    if (request.getParameter("pedt") == null) {
                %>
                <div class="title">Profile</div>
                <h2 style="padding-left: 131px">Your information</h2>
                <div class="profile " >

                    <span class="tag">Your Name</span>
                    <span style="background-color: floralwhite"
                          class="val"><%=user.getFirstName() + " " %><%=user.getLastName()%></span><br/>
                    <span class="tag">Email</span><span style="background-color: floralwhite" class="val"><%=user.getEmail()%></span><br/>
                    <span class="tag">Username</span><span style="background-color: floralwhite" class="val"><%=user.getUserName()%></span><br/>
                </div>
                <%
                    if (user.getType().equals("admin")) {
                %>
                <br/>
                <a href="adm-page.jsp?pgprt=0&pedt=1"><span class="add-btn">Edit Profile</span></a>
                <%
                } else {
                %><br/>
                <a href="std-page.jsp?pgprt=0&pedt=1"><span class="add-btn">Edit Profile</span></a>
                <%
                    }
                %>

                <%
                } else {
                %>

                <!-- Start of Edit Form --->
                <div class="title">Edit Profile</div>
                <div class="central-div form-style-6" style="position:inherit;margin-top: 70px;">
                    <form action="user.action">
                        <input type="hidden" name="page" value="profile">
                        <input type="hidden" name="utype" value="<%=user.getType()%>">
                        <table>

                            <tr>
                                <td>
                                    <label>First Name</label>
                                </td>
                                <td>
                                    <input type="text" name="fname" value="<%=user.getFirstName() %>" class="text"
                                           placeholder="First Name">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>Last Name</label>
                                </td>
                                <td>
                                    <input type="text" name="lname" value="<%=user.getLastName() %>" class="text"
                                           placeholder="Last Name">
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <label>User Name</label>
                                </td>
                                <td>
                                    <input type="text" name="uname" value="<%=user.getUserName() %>" class="text"
                                           placeholder="User Name">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>Email</label>
                                </td>
                                <td>
                                    <input type="email" name="email" value="<%=user.getEmail() %>" class="text"
                                           placeholder="Email">
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <label>Password</label>
                                </td>
                                <td>
                                    <input type="password" value="<%=user.getPassword() %>" name="pass" class="text"
                                           placeholder="Password">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>Contact No</label>
                                </td>
                                <td>
                                    <input type="text" name="contactno" value="<%=user.getContact() %>" class="text"
                                           placeholder="Contact No">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>City</label>
                                </td>
                                <td>
                                    <input type="text" name="city" value="<%=user.getCity() %>" class="text"
                                           placeholder="City">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>Address</label>
                                </td>
                                <td>
                                    <input type="text" name="address" value="<%=user.getAddress() %>" class="text"
                                           placeholder="Address">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <center>

                                        <input type="submit" value="Done" class="button">
                                    </center>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>


                <%
                    }
                %>

            </div>
        </div>