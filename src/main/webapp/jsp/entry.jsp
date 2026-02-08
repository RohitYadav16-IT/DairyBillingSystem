<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, util.DBConnection" %>

<jsp:include page="header.jsp" />

<%
    Connection con = null;
    Statement st = null;

    try {
        con = DBConnection.getConnection();
        st = con.createStatement();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<div class="container mt-4">
    <h3 class="mb-3">Daily Entries</h3>

    <ul class="nav nav-tabs">
        <li class="nav-item">
            <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#customer">
                Add Customer
            </button>
        </li>
        <li class="nav-item">
            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#milk">
                Milk Entry
            </button>
        </li>
        <li class="nav-item">
            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#product">
                Product Entry
            </button>
        </li>
    </ul>

    <div class="tab-content mt-3">

        <div class="tab-pane fade show active" id="customer">
            <form action="../MainServlet" method="post" class="card card-body shadow-sm">
                <input type="hidden" name="action" value="addCustomer">

                <div class="mb-2">
                    <label class="form-label">Customer Name</label>
                    <input type="text" name="name" class="form-control" required>
                </div>

                <div class="mb-2">
                    <label class="form-label">Contact</label>
                    <input type="text" name="contact" class="form-control">
                </div>

                <div class="mb-2">
                    <label class="form-label">Address</label>
                    <textarea name="address" class="form-control"></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Default Milk Type</label>
                    <select name="milkType" class="form-select">
                        <option value="Cow">Cow</option>
                        <option value="Buffalo">Buffalo</option>
                    </select>
                </div>

                <button class="btn btn-primary">Save Customer</button>
            </form>
        </div>

        <div class="tab-pane fade" id="milk">
            <form action="../MainServlet" method="post" class="card card-body shadow-sm">
                <input type="hidden" name="action" value="milkEntry">

                <div class="mb-3">
                    <label class="form-label">Select Customer</label>
                    <select name="customerId" class="form-select" required>
                        <option value="">-- Select Customer --</option>
                        <%
                            ResultSet rs = st.executeQuery(
                                "SELECT customer_id, name, address FROM customer"
                            );
                            while (rs.next()) {
                        %>
                        <option value="<%= rs.getInt("customer_id") %>">
                            <%= rs.getInt("customer_id") %> -
                            <%= rs.getString("name") %> |
                            <%= rs.getString("address") %>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Cow Milk (Liters)</label>
                        <input type="number" step="0.01"
                               name="cowQty"
                               class="form-control"
                               placeholder="₹60 / liter">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Buffalo Milk (Liters)</label>
                        <input type="number" step="0.01"
                               name="buffaloQty"
                               class="form-control"
                               placeholder="₹74 / liter">
                    </div>
                </div>

                <button class="btn btn-success">Save Milk Entry</button>
            </form>
        </div>

        <div class="tab-pane fade" id="product">
            <form action="../MainServlet" method="post" class="card card-body shadow-sm">
                <input type="hidden" name="action" value="productEntry">

                <div class="mb-3">
                    <label class="form-label">Select Customer</label>
                    <select name="customerId" class="form-select" required>
                        <option value="">-- Select Customer --</option>
                        <%
                            ResultSet rs2 = st.executeQuery(
                                "SELECT customer_id, name, address FROM customer"
                            );
                            while (rs2.next()) {
                        %>
                        <option value="<%= rs2.getInt("customer_id") %>">
                            <%= rs2.getInt("customer_id") %> -
                            <%= rs2.getString("name") %> |
                            <%= rs2.getString("address") %>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="mb-2">
                    <label class="form-label">Product Name</label>
                    <input type="text" name="productName" class="form-control" required>
                </div>

                <div class="row mb-2">
                    <div class="col">
                        <input type="number" name="kg" class="form-control" placeholder="Kg" value="0">
                    </div>
                    <div class="col">
                        <input type="number" name="grams" class="form-control" placeholder="Grams" value="0">
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Rate per Kg (₹)</label>
                    <input type="number" step="0.01" name="rate" class="form-control" required>
                </div>

                <button class="btn btn-warning">Save Product Entry</button>
            </form>
        </div>

    </div>
</div>

<div class="d-flex justify-content-center">
    <a href="dashboard.jsp" class="btn btn-secondary mt-3">
        ← Back to Home
    </a>
</div>

<%
    if (st != null) st.close();
    if (con != null) con.close();
%>



<jsp:include page="footer.jsp" />
