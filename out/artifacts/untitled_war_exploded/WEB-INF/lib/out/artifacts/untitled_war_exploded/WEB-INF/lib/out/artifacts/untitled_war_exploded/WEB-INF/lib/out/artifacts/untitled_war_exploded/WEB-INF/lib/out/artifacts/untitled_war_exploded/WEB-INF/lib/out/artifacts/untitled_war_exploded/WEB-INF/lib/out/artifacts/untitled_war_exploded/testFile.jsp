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
            let offset = $(this).data()  //get the offset for the link clicked
            $.ajax({                            //ajax
                type : 'POST',
                url : '../auctionsDisplay',
                data : {
                    "type"      : "1",
                    "category"  : category,
                    "limit"     : limit,        //set limit
                    "offset"    : offset        //set offset
                }
                    .done(function(){               //success is deprecated, use done
                        $("#result2").html(data);
                    })
                    .fail(function(jqXHR){          //dump the info to the console (hit f12 to see that in a browser)
                        console.log(jqXHR);
                        alert("aw damn, something bad happened");
                    })
                    .always(function(){             //this always happens, doesn't matter if it hits done or fail
                        alert("I always happen, done or fail, rain or shine.  You can remove me.");
                    })
        })
    </script>
</body>
</html>
