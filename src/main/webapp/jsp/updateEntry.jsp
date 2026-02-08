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
%>

<div class="container mt-4">
    <h3 class="mb-3">Update Entries</h3>

    <h5>Milk Entries</h5>
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>Date</th>
                <th>Milk Type</th>
                <th>Quantity (L)</th>
                <th>Rate</th>
                <th>Update</th>
            </tr>
        </thead>
        <tbody>

        <%
            try (Connection con = DBConnection.getConnection()) {

                PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM milk_entry WHERE customer_id=?"
                );
                ps.setInt(1, customerId);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
        %>
            <tr>
                <form action="../MainServlet" method="post">
                    <input type="hidden" name="action" value="updateMilkEntry">
                    <input type="hidden" name="milkEntryId" value="<%= rs.getInt("milk_entry_id") %>">

                    <td><%= rs.getDate("entry_date") %></td>
                    <td><%= rs.getString("milk_type") %></td>

                    <td>
                        <input type="number" step="0.01" name="quantity"
                               value="<%= rs.getDouble("quantity_liters") %>"
                               class="form-control">
                    </td>

                    <td>
                        <input type="number" step="0.01" name="rate"
                               value="<%= rs.getDouble("rate_per_liter") %>"
                               class="form-control">
                    </td>

                    <td>
                        <button class="btn btn-sm btn-success">Save</button>
                    </td>
                </form>
            </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>

    <h5 class="mt-4">Product Entries</h5>
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>Date</th>
                <th>Product</th>
                <th>Quantity (Kg)</th>
                <th>Rate</th>
                <th>Update</th>
            </tr>
        </thead>
        <tbody>

        <%
            try (Connection con = DBConnection.getConnection()) {

                PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM product WHERE customer_id=?"
                );
                ps.setInt(1, customerId);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
        %>
            <tr>
                <form action="../MainServlet" method="post">
                    <input type="hidden" name="action" value="updateProductEntry">
                    <input type="hidden" name="productId" value="<%= rs.getInt("product_id") %>">

                    <td><%= rs.getDate("entry_date") %></td>
                    <td><%= rs.getString("product_name") %></td>

                    <td>
                        <input type="number" step="0.01" name="quantity"
                               value="<%= rs.getDouble("quantity_kg") %>"
                               class="form-control">
                    </td>

                    <td>
                        <input type="number" step="0.01" name="rate"
                               value="<%= rs.getDouble("rate_per_kg") %>"
                               class="form-control">
                    </td>

                    <td>
                        <button class="btn btn-sm btn-success">Save</button>
                    </td>
                </form>
            </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>

    <a href="viewCustomers.jsp" class="btn btn-secondary mt-3">
        ← Back to Customers
    </a>
</div>

<jsp:include page="footer.jsp" />
