<%--
  Created by IntelliJ IDEA.
  User: rin0806
  Date: 11/15/2020
  Time: 12:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>
</head>
<body>
    <div id="content">

    </div>
    <a class="paging" href="paging.action">1</a>
    <a class="paging" href="paging.action">2</a>
    <a class="paging" href="paging.action">3</a>
    <a class="paging" href="paging.action">4</a>

    <script>
        $('.paging').click(function (e) {
            e.preventDefault(); //prevent default click behavior for a link
            let limit = 5;                         //hard code the limit (rows/page)
            let offset = $(this).text(); //get the offset for the link clicked
            $.ajax({                            //ajax
                'type': 'POST',
                'url': 'http://localhost:8080/paging?action=questionExam&coursename=khoa12&index='+offset,
                'success': function (data) {
                    $("#content").html()
                }
            });
        })
    </script>
</body>
</html>
