<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error | Dairy Billing System</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container d-flex justify-content-center align-items-center vh-100">
    <div class="card shadow-lg text-center" style="max-width: 450px;">
        <div class="card-header bg-danger text-white">
            <h4>Something Went Wrong</h4>
        </div>

        <div class="card-body">
            <p class="mb-3">
                An unexpected error occurred while processing your request.
            </p>

            <p class="text-muted small">
                Please try again or contact the administrator.
            </p>

            <a href="dashboard.jsp" class="btn btn-primary mt-2">
                Go to Dashboard
            </a>
            <a href="entry.jsp" class="btn btn-secondary mt-2">
                Back to Entries
            </a>
        </div>

        <div class="card-footer text-muted small">
            Dairy Billing System
        </div>
    </div>
</div>

</body>
</html>
