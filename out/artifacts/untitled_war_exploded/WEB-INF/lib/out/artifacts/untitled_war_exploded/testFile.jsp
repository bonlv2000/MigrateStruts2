<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <div id="content">

    </div>
    <a class="paging1" href="paging.action">1</a>
    <a class="paging" href="paging.action">2</a>
    <a class="paging" href="paging.action">3</a>
    <a class="paging" href="paging.action">4</a>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script>
        let x = 10;
        $('.paging').click((e) => {
            x++;
            e.preventDefault(); //prevent default click behavior for a link
            let offset = $(e.target).text(); //get the offset for the link clicked
            let content = $("#content");
            $.ajax({
                'type': 'get',
                'url': 'http://localhost:8080/paging?action=questionExam&coursename=khoa12&index='+offset,
                'success': function (data) {
                    $("#content").html("");
                    for (let item of data) {
                        content.append("<p>"+item.question+"</p>");
                    }
                }
            });
        })
    </script>
</body>
</html>
