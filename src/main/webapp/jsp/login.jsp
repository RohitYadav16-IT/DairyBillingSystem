<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dairy Billing System | Login</title>

    
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet">
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
        rel="stylesheet">

    <style>
    body {
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .login-card {
        background: rgba(255, 255, 255, 0.9);
        border-radius: 12px;
        padding: 30px;
        width: 100%;
        max-width: 380px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.3);
    }

    .login-title {
        font-weight: 600;
        text-align: center;
        margin-bottom: 20px;
    }
    .login-title img {
        filter: drop-shadow(1px 1px 2px rgba(0,0,0,0.3));
    }
</style>


    
    <script>
        document.addEventListener("DOMContentLoaded", function () {

            const dairyBackgrounds = [
                "../images/dairy1.jpg",
                "../images/dairy2.jpg",
                "../images/dairy3.jpg",
                "../images/dairy4.jpg"
            ];

            const bg =
                dairyBackgrounds[Math.floor(Math.random() * dairyBackgrounds.length)];

            document.body.style.backgroundImage = "url('" + bg + "')";
        });
    </script>
</head>

<body>

<div class="login-card">

<h4 class="login-title d-flex align-items-center justify-content-center gap-2">
    <img src="../images/milk-can.png"
         alt="Milk Can"
         width="66"
         height="66">
    Dairy Billing System
</h4>


    <form action="../MainServlet" method="post">
        <input type="hidden" name="action" value="login">

        <div class="mb-3">
            <label class="form-label">Username</label>
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-person-fill"></i>
                </span>
                <input type="text" name="username" class="form-control" required>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-lock-fill"></i>
                </span>
                <input type="password"
                       name="password"
                       id="password"
                       class="form-control"
                       required>
                <span class="input-group-text"
                      style="cursor:pointer"
                      onclick="togglePassword()">
                    <i class="bi bi-eye-fill" id="eyeIcon"></i>
                </span>
            </div>
        </div>

        <%
            if ("1".equals(request.getParameter("error"))) {
        %>
            <div class="alert alert-danger py-1">
                Invalid username or password
            </div>
        <%
            }
        %>

        <button class="btn btn-success w-100 mt-2">
            <i class="bi bi-box-arrow-in-right"></i>
            Login
        </button>
    </form>
    


</div>

<script>
    function togglePassword() {
        const pwd = document.getElementById("password");
        const eye = document.getElementById("eyeIcon");

        if (pwd.type === "password") {
            pwd.type = "text";
            eye.classList.remove("bi-eye-fill");
            eye.classList.add("bi-eye-slash-fill");
        } else {
            pwd.type = "password";
            eye.classList.remove("bi-eye-slash-fill");
            eye.classList.add("bi-eye-fill");
        }
    }
</script>

</body>
</html>
