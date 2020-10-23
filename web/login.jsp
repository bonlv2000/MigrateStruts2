<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login V1</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="/Common/test/images/icons/favicon.ico"/>
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/Common/test/vendor/bootstrap/css/bootstrap.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/Common/test/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/Common/test/vendor/animate/animate.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/Common/test/vendor/css-hamburgers/hamburgers.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/Common/test/vendor/select2/select2.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/Common/test/css/util.css">
    <link rel="stylesheet" type="text/css" href="/Common/test/css/main.css">
    <!--===============================================================================================-->
</head>
<body>

<div class="limiter">
    <div class="container-login100">
        <div class="wrap-login100" style="padding-top: 100px">
            <div class="login100-pic js-tilt" data-tilt>
                <img src="/Common/test/images/img-01.png" alt="IMG">
            </div>

            <form class="login100-form validate-form" action="LoginController" method="post">
					<span class="login100-form-title">
						<img src="/Common/login/IMG/login.png" height="70" width="70" style="margin-bottom: .5rem"><br>
                        Login
					</span>

                <div class="wrap-input100 validate-input" data-validate = "Valid email is required: ex@abc.xyz">
                    <input class="input100" type="text" name="username" placeholder="username">
                    <span class="focus-input100"></span>
                    <span class="symbol-input100">
							<i class="fa fa-envelope" aria-hidden="true"></i>
						</span>
                </div>

                <div class="wrap-input100 validate-input" data-validate = "Password is required">
                    <input class="input100" type="password" name="password" placeholder="Password">
                    <span class="focus-input100"></span>
                    <span class="symbol-input100">
							<i class="fa fa-lock" aria-hidden="true"></i>
						</span>
                </div>

                <div class="container-login100-form-btn">
                    <button class="login100-form-btn" id="login">
                        Login
                    </button>

                    <a href="index.jsp" class="login100-form-btn btn btn-danger" style="margin-top: 1rem;background-color: #00acc1" >
                       Home
                    </a>
                </div>

                <div class="text-center p-t-12" id="alo">
						<span class="txt1" style="font-size: 1.2rem">
							Forgot
						</span>
                    <a class="txt2" href="HomeController?action=resetPassword" style="font-size: 1.2rem">
                        Username / Password?
                    </a>

                </div>

                <div class="text-center p-t-136" style="padding-top: 2rem;">
                    <a class="txt2" href="HomeController?action=register" style="font-size: 1.5rem">
                        Create your Account
                        <i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>

                    </a>
                </div>

            </form>
        </div>
    </div>
<%--    <%--%>
<%--        if (request.getSession().getAttribute("userStatus") != null) {--%>
<%--            System.out.println("its called");--%>
<%--            if (request.getSession().getAttribute("userStatus").equals("-1")) {--%>
<%--                System.out.println("now inside");--%>
<%--    %>--%>
<%--    <script>--%>
<%--        alert("Invalid username or password")--%>
<%--    </script>--%>
<%--    <%--%>
<%--            }--%>
<%--        }--%>
<%--    %>--%>
    <script>
        document.getElementById("login").addEventListener("click",()=> {

        })
    </script>
</div>




<!--===============================================================================================-->
<script src="/Common/test/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
<script src="/Common/test/vendor/bootstrap/js/popper.js"></script>
<script src="/Common/test/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
<script src="/Common/test/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
<script src="/Common/test/vendor/tilt/tilt.jquery.min.js"></script>
<script >
    $('.js-tilt').tilt({
        scale: 1.1
    })


</script>
<!--===============================================================================================-->
<script src="/test/js/main.js"></script>

</body>
</html>




