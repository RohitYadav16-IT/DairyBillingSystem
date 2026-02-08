<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<jsp:include page="header.jsp" />

<style>
.update-box {
    background-color: #212529;
    color: white;
}
.update-box label {
    color: #ddd;
}
</style>


<div class="container">
    <div class="row justify-content-center align-items-center"
         style="min-height: 80vh;">

        <div class="col-md-5 col-lg-4">

            <h3 class="mb-4 text-center">Update Admin Details</h3>

            <% if ("invalid".equals(request.getParameter("error"))) { %>
                <div class="alert alert-danger">
                    Old password is incorrect.
                </div>
            <% } %>

            <form action="../MainServlet" method="post"
      class="card card-body shadow-sm update-box">


                <input type="hidden" name="action" value="updateAdmin">

                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <input type="text"
                           name="username"
                           class="form-control"
                           value="<%= session.getAttribute("username") %>"
                           required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Old Password</label>
                    <input type="password"
                           name="oldPassword"
                           class="form-control"
                           required>
                </div>

                <div class="mb-3">
                    <label class="form-label">New Password</label>
                    <input type="password"
                           name="newPassword"
                           class="form-control"
                           required>
                </div>

                <button class="btn btn-primary w-100 mb-2">
                    Save Changes
                </button>

                <a href="dashboard.jsp"
                   class="btn btn-secondary w-100">
                    Cancel
                </a>
            </form>

        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
