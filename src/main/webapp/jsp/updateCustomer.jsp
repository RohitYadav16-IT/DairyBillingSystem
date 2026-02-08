<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, util.DBConnection" %>

<jsp:include page="header.jsp" />

<%
    String customerIdStr = request.getParameter("customerId");
    if (customerIdStr == null) {
        response.sendRedirect("viewCustomers.jsp");
        return;
    }

    int customerId = Integer.parseInt(customerIdStr);

    String name = "", contact = "", address = "", milkType = "";

    try (Connection con = DBConnection.getConnection()) {
        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM customer WHERE customer_id=?"
        );
        ps.setInt(1, customerId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            contact = rs.getString("contact");
            address = rs.getString("address");
            milkType = rs.getString("milk_type");
        }
    }
%>

<div class="container mt-4">
    <h3 class="mb-3">Update Customer</h3>

    <form action="../MainServlet" method="post" class="card card-body shadow-sm">
        <input type="hidden" name="action" value="updateCustomer">
        <input type="hidden" name="customerId" value="<%= customerId %>">

        <div class="mb-2">
            <label class="form-label">Customer Name</label>
            <input type="text" name="name" class="form-control" value="<%= name %>" required>
        </div>

        <div class="mb-2">
            <label class="form-label">Contact</label>
            <input type="text" name="contact" class="form-control" value="<%= contact %>">
        </div>

        <div class="mb-2">
            <label class="form-label">Address</label>
            <textarea name="address" class="form-control"><%= address %></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Default Milk Type</label>
            <select name="milkType" class="form-select">
                <option value="Cow" <%= "Cow".equals(milkType) ? "selected" : "" %>>Cow</option>
                <option value="Buffalo" <%= "Buffalo".equals(milkType) ? "selected" : "" %>>Buffalo</option>
            </select>
        </div>

        <button class="btn btn-primary">Update Customer</button>
        <a href="viewCustomers.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>

<jsp:include page="footer.jsp" />
