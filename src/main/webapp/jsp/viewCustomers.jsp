<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, util.DBConnection" %>

<jsp:include page="header.jsp" />

<div class="container mt-4">

    <h3 class="mb-3">Customer Details</h3>

    <%
        if ("deleted".equals(request.getParameter("success"))) {
    %>
        <div class="alert alert-success">
            Customer and related entries deleted successfully.
        </div>
    <%
        }
    %>

    <div class="card shadow-sm">
        <div class="card-body">

            <table class="table table-bordered table-hover table-striped align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Contact</th>
                        <th>Address</th>
                        <th>Milk Type</th>
                        <th style="width:280px;">Actions</th>
                    </tr>
                </thead>
                <tbody>

                <%
                    Connection con = null;
                    Statement st = null;
                    ResultSet rs = null;
                    boolean hasData = false;

                    try {
                        con = DBConnection.getConnection();
                        st = con.createStatement();
                        rs = st.executeQuery(
                            "SELECT customer_id, name, contact, address, milk_type FROM customer"
                        );

                        while (rs.next()) {
                            hasData = true;
                %>
                    <tr>
                        <td><%= rs.getInt("customer_id") %></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("contact") %></td>
                        <td><%= rs.getString("address") %></td>
                        <td>
                            <span class="badge 
                                <%= "Buffalo".equals(rs.getString("milk_type"))
                                        ? "bg-warning text-dark"
                                        : "bg-success" %>">
                                <%= rs.getString("milk_type") %>
                            </span>
                        </td>

                        <td>
                            <a href="updateCustomer.jsp?customerId=<%= rs.getInt("customer_id") %>"
                               class="btn btn-sm btn-primary">
                                Update Customer
                            </a>

                            <a href="updateEntry.jsp?customerId=<%= rs.getInt("customer_id") %>"
                               class="btn btn-sm btn-info text-white">
                                Update Entry
                            </a>

                            <a href="../MainServlet?action=deleteCustomer&customerId=<%= rs.getInt("customer_id") %>"
                               class="btn btn-sm btn-danger"
                               onclick="return confirm(
                                   'Are you sure you want to delete this customer?\n\nThis will delete all related milk and product entries.'
                               );">
                                Delete
                            </a>
                        </td>
                    </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                %>
                    <tr>
                        <td colspan="6" class="text-center text-danger">
                            Error loading customer records.
                        </td>
                    </tr>
                <%
                    } finally {
                        if (rs != null) rs.close();
                        if (st != null) st.close();
                        if (con != null) con.close();
                    }

                    if (!hasData) {
                %>
                    <tr>
                        <td colspan="6" class="text-center">
                            No customers found.
                        </td>
                    </tr>
                <%
                    }
                %>

                </tbody>
            </table>

        </div>
    </div>

    <div class="d-flex justify-content-center">
    <a href="dashboard.jsp" class="btn btn-secondary mt-3">
        ← Back to Home
    </a>
</div>


</div>

<jsp:include page="footer.jsp" />
