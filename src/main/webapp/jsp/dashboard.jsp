<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dairy Billing System | Dashboard</title>

   
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <style>
        
        html, body {
            height: 100%;
            margin: 0;
        }

        body {
            display: flex;
            flex-direction: column;
        }

        
        #dashboard-bg {
            flex: 1;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            display: flex;
            flex-direction: column;
        }

        
        .dashboard-content {
            flex: 1;
        }

        
        .welcome-box {
            display: inline-block;
            padding: 12px 20px;
            border-radius: 12px;
            background: rgba(0, 0, 0, 0.55);
            color: #fff;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
            backdrop-filter: blur(4px);
        }

        .card {
            background: rgba(255, 255, 255, 0.92);
        }
    </style>

    <script>
        window.onload = function () {
            const backgrounds = [
                "../images/dairy1.jpg",
                "../images/dairy2.jpg",
                "../images/dairy3.jpg",
                "../images/dairy4.jpg"
            ];

            const randomBg =
                backgrounds[Math.floor(Math.random() * backgrounds.length)];

            document.getElementById("dashboard-bg")
                .style.backgroundImage = "url('" + randomBg + "')";
        };
    </script>
</head>

<body>

<div id="dashboard-bg">

    <jsp:include page="header.jsp" />

    <div class="dashboard-content">
        <div class="container mt-4">

            <div class="mb-4">
                <h3 class="welcome-box">
                    Welcome, <%= session.getAttribute("username") %>
                </h3>
            </div>

            <div class="row g-4">

                <div class="col-md-4">
                    <div class="card shadow text-center h-100">
                        <div class="card-body">
                            
                            <h5 class="card-title">
    <i class="bi bi-journal-text text-primary"></i>
    Daily Entries
</h5>
                            
                            
                            <p class="card-text">Add customers, milk & products</p>
                            <a href="entry.jsp" class="btn btn-primary">Go</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card shadow text-center h-100">
                        <div class="card-body">
                            
                            <h5 class="card-title">
    <i class="bi bi-people-fill text-info"></i>
    View Customers
</h5>
                            
                            
                            <p class="card-text">All registered customers</p>
                            <a href="viewCustomers.jsp" class="btn btn-info">View</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card shadow text-center h-100">
                        <div class="card-body">
                            
                            <h5 class="card-title">
    <i class="bi bi-bar-chart-line-fill text-warning"></i>
    Reports
</h5>
                            
                            
                            <p class="card-text">Monthly billing reports</p>
                            <a href="reports.jsp" class="btn btn-warning">View Reports</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp" />

</div>

</body>
</html>
