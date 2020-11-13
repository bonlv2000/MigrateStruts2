<%@ page import="java.util.ArrayList" %>
<%@ page import="Models.classes.Questions" %>
<%@ page import="Models.DatabaseClass" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="pDAO" class="Models.DatabaseClass"/>


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
    </center>
</div>