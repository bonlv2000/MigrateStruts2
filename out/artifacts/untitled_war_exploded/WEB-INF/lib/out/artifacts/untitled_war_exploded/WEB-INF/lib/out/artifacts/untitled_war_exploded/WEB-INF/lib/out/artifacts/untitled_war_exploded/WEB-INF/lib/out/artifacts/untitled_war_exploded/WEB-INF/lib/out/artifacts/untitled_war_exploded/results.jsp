<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="Models.classes.Answers" %>
<%@page import="Models.classes.Exams" %>
<%@page import="java.util.ArrayList" %>
<%@ page import="Models.DatabaseClass" %>
<jsp:useBean id="pDAO" class="Models.DatabaseClass" scope="page"/>
<%
    int totalPage = new DatabaseClass().totalPageResult(session.getAttribute("query").toString());
    session.setAttribute("totalPageResult",totalPage);
%>
<style>
    .panel {
        margin: 3rem auto;
    }
</style>

<!-- CONTENT AREA -->
<div class="content-area">
    <div class="panel" style="float: left;max-width: 900px">
        <%
            if (request.getParameter("eId") == null) {
        %>
        <div class="title">All Results</div>
        <div class="dropdown show" style="text-align: center">
            <a style="margin-right: 5rem" class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Search By Result
            </a>

            <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                <a class="dropdown-item" href="paging?action=result">All</a>
                <a class="dropdown-item" href="paging?action=result&query=Pass">Pass</a>
                <a class="dropdown-item" href="paging?action=result&query=Fail">Fail</a>
                <a class="dropdown-item" href="paging?action=result&query=Terminated">Terminated</a>
            </div>
        </div>
        <table id="rounded-corner">
            <thead>
            <tr>
                <th scope="col" class="rounded-company">Date</th>
                <th scope="col" class="rounded-q1">Course</th>
                <th scope="col" class="rounded-q2">Time</th>
                <th scope="col" class="rounded-q3">Status</th>
                <th scope="col" class="rounded-q4">Action</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach items="${sessionScope.pagingItems}" var="item">
                <tr>
                    <td>${item.date}</td>
                    <td>${item.cName}</td>
                    <td>${item.startTime} - ${item.endTime}</td>
                    <c:if test="${item.status.equals('Pass')}">
                        <td style="background: #00cc33;color:white">${item.status}</td>
                    </c:if>
                    <c:if test="${item.status.equals('Fail')}">
                        <td style="background: #ff3333;color:white">${item.status}</td>
                    </c:if>
                    <c:if test="${item.status.equals('Terminated')}">
                        <td style="background: bisque ;">Terminated</td>
                    </c:if>
                    <td><a href="paging?action=resultDetail&eId=${item.examId}">Details</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <nav aria-label="Page navigation example" style="margin-left: 2rem">
            <ul class="pagination">
                <c:forEach begin="1" end="${sessionScope.totalPageResult}" var="i">
                    <c:if test="${sessionScope.index.equals(i)}">
                        <li class="page-item active"><a class="page-link" href="paging.action?action=result&index=${i}&query=${sessionScope.query}">${i}</a></li>
                    </c:if>
                    <c:if test="${!sessionScope.index.equals(i)}">
                        <li class="page-item"><a class="page-link" href="paging.action?action=result&index=${i}&query=${sessionScope.query}">${i}</a></li>
                    </c:if>
                </c:forEach>
            </ul>
        </nav>

        <%
        } else {
        %>
        <%
            totalPage = new DatabaseClass().totalPageAnswer(Integer.parseInt(session.getAttribute("eId").toString()),session.getAttribute("query").toString());
            session.setAttribute("totalPageResult",totalPage);
        %>
        <div class="title">Result Details</div>
        <form action="paging.action" class="row" method="post">
            <input type="hidden" name="action" value="resultDetail">
            <input type="hidden" name="eId" value=<%=request.getParameter("eId")%>>
            <div class="form-group col-6" style="margin-left: 2rem">
                <input name="query" type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter question search">
            </div>
            <button type="submit" class="btn btn-primary " style="height: 40px">Search</button>
            <a href="paging?action=result" class="btn btn-danger" style="height: 40px; margin-left: 10px">Back to result</a>
        </form>
        <table id="gradient-style">
            <c:forEach items="${sessionScope.pagingItems}" var="item">
                <tr>
                    <td rowspan="2">Detail)</td>
                    <td colspan="2">${item.question}
                    </td>
                    <td style="color: red" rowspan="3">${item.status}
                    </td>
                </tr>
                <tr>
                    <td style="color: red">${item.answer}
                    </td>
                    <td >Corect Answer: ${item.correctAns}
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="background: white"></td>

                </c:forEach>

        </table>
        <nav aria-label="Page navigation example" style="margin-left: 2rem">
            <ul class="pagination">
                <c:forEach begin="1" end="${sessionScope.totalPageResult}" var="i">
                    <c:if test="${sessionScope.index.equals(i)}">
                        <li class="page-item active"><a class="page-link" href="paging.action?action=resultDetail&index=${i}&query=${sessionScope.query}&eId=${sessionScope.eId}">${i}</a></li>
                    </c:if>
                    <c:if test="${!sessionScope.index.equals(i)}">
                        <li class="page-item"><a class="page-link" href="paging.action?action=resultDetail&index=${i}&query=${sessionScope.query}&eId=${sessionScope.eId}">${i}</a></li>
                    </c:if>
                </c:forEach>
            </ul>
        </nav>
        <%
            }
        %>
    </div>
</div>