<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, util.DBConnection, java.text.DateFormatSymbols, java.time.*" %>

<jsp:include page="header.jsp" />

<style>
@media print {
    body { font-size: 12px; color: #000; }
    .no-print, form, nav, footer { display: none !important; }
    #printArea { width: 100%; }
    table { width: 100%; border-collapse: collapse; }
    table th, table td { border: 1px solid #000; padding: 6px; }
    .table-dark th { background-color: #eaeaea !important; color: #000 !important; }
    hr { border: 1px solid #000; }
}

.payment-box {
    display: flex;
    gap: 40px;
    margin: 20px 0;
}
.payment-box label {
    font-size: 18px;
    font-weight: bold;
}
.payment-box input {
    transform: scale(2);
    margin-right: 8px;
}
@media print { .payment-box { display: none; } }

.stamp {
    display: none;
    width: 140px;
    height: 140px;
    border-radius: 60%;
    border: 4px solid;
    text-align: center;
    font-size: 18px;
    font-weight: bold;
    padding-top: 32px;
}
.stamp span {
    display: block;
    font-size: 11px;
    margin-top: 2px;
}
.stamp-date {
    font-size: 10px;
    margin-top: 3px;
}
.stamp.paid { color: #1a7f37; border-color: #1a7f37; }
.stamp.unpaid { color: #b02a37; border-color: #b02a37; }


.total-summary-box {
    border: 1px solid #000;
    padding: 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
</style>

<div class="container mt-4">
<h3 class="mb-3 no-print">Monthly Customer Report</h3>

<%
String selectedCustomerId = request.getParameter("customerId");
String selectedMonth = request.getParameter("month");
String selectedYear = request.getParameter("year");

String customerName = "";
String customerAddress = "";

DateFormatSymbols dfs = new DateFormatSymbols();
String[] monthNames = dfs.getMonths();
%>

<form method="get" class="card card-body shadow-sm mb-4 no-print">
<div class="row">

<div class="col-md-4">
<label class="form-label">Customer</label>
<select name="customerId" class="form-select" required>
<option value="">-- Select Customer --</option>
<%
try (Connection con = DBConnection.getConnection();
     Statement st = con.createStatement();
     ResultSet rs = st.executeQuery("SELECT customer_id, name, address FROM customer")) {

while (rs.next()) {
int cid = rs.getInt("customer_id");
String cname = rs.getString("name");
String caddr = rs.getString("address");

if (selectedCustomerId != null && selectedCustomerId.equals(String.valueOf(cid))) {
customerName = cname;
customerAddress = caddr;
}
%>
<option value="<%= cid %>" <%= selectedCustomerId != null && selectedCustomerId.equals(String.valueOf(cid)) ? "selected" : "" %>>
<%= cid %> - <%= cname %> | <%= caddr %>
</option>
<% } } %>
</select>
</div>

<div class="col-md-4">
<label class="form-label">Month</label>
<select name="month" class="form-select" required>
<% for (int m = 1; m <= 12; m++) { %>
<option value="<%= m %>" <%= selectedMonth != null && selectedMonth.equals(String.valueOf(m)) ? "selected" : "" %>>
<%= monthNames[m - 1] %>
</option>
<% } %>
</select>
</div>

<div class="col-md-4">
<label class="form-label">Year</label>
<input type="number" name="year" class="form-control"
value="<%= selectedYear != null ? selectedYear : Year.now().getValue() %>" required>
</div>

</div>
<button class="btn btn-primary mt-3">View Report</button>
</form>

<%
if (selectedCustomerId != null && selectedMonth != null && selectedYear != null) {

int customerId = Integer.parseInt(selectedCustomerId);
int month = Integer.parseInt(selectedMonth);
int year = Integer.parseInt(selectedYear);

String monthName =
    Month.of(month).getDisplayName(java.time.format.TextStyle.FULL, java.util.Locale.ENGLISH);

double milkTotal = 0;
double productTotal = 0;
%>

<div class="d-flex justify-content-end mb-3 no-print">
<button onclick="printPDF()" class="btn btn-success">🖨️ Save PDF</button>
</div>

<div class="payment-box no-print">
<label><input type="checkbox" id="paidCheck" onclick="togglePayment('paid')"> PAID</label>
<label><input type="checkbox" id="unpaidCheck" onclick="togglePayment('unpaid')"> UNPAID</label>
</div>

<div id="printArea">

<h4 class="text-center">Monthly Customer Report</h4>

<p>
<strong>Customer:</strong> <%= customerName %><br>
<strong>Address:</strong> <%= customerAddress %><br>
<strong>Month / Year:</strong> <%= monthName %> / <%= year %>
</p>

<h5>Milk Summary</h5>
<table class="table">
<thead class="table-dark">
<tr><th>Milk Type</th><th>Total Liters</th><th>Amount (₹)</th></tr>
</thead>
<tbody>
<%
try (Connection con = DBConnection.getConnection()) {
PreparedStatement ps = con.prepareStatement(
"SELECT milk_type, SUM(quantity_liters) qty, SUM(quantity_liters * rate_per_liter) amount " +
"FROM milk_entry WHERE customer_id=? AND YEAR(entry_date)=? AND MONTH(entry_date)=? GROUP BY milk_type");
ps.setInt(1, customerId);
ps.setInt(2, year);
ps.setInt(3, month);
ResultSet rs = ps.executeQuery();
while (rs.next()) {
milkTotal += rs.getDouble("amount");
%>
<tr>
<td><%= rs.getString("milk_type") %></td>
<td><%= rs.getDouble("qty") %></td>
<td>₹ <%= rs.getDouble("amount") %></td>
</tr>
<% } } %>
</tbody>
</table>

<h5>Product Summary</h5>
<table class="table">
<thead class="table-dark">
<tr><th>Product</th><th>Total Qty (Kg)</th><th>Rate</th><th>Amount (₹)</th></tr>
</thead>
<tbody>
<%
try (Connection con = DBConnection.getConnection()) {
PreparedStatement ps = con.prepareStatement(
"SELECT product_name, SUM(quantity_kg) qty, rate_per_kg, SUM(quantity_kg * rate_per_kg) amount " +
"FROM product WHERE customer_id=? AND YEAR(entry_date)=? AND MONTH(entry_date)=? GROUP BY product_name, rate_per_kg");
ps.setInt(1, customerId);
ps.setInt(2, year);
ps.setInt(3, month);
ResultSet rs = ps.executeQuery();
while (rs.next()) {
productTotal += rs.getDouble("amount");
%>
<tr>
<td><%= rs.getString("product_name") %></td>
<td><%= rs.getDouble("qty") %></td>
<td>₹ <%= rs.getDouble("rate_per_kg") %></td>
<td>₹ <%= rs.getDouble("amount") %></td>
</tr>
<% } } %>
</tbody>
</table>

<div class="total-summary-box">
<div>
<h5>Total Summary</h5>
<p>Milk Total: <strong>₹ <%= milkTotal %></strong></p>
<p>Product Total: <strong>₹ <%= productTotal %></strong></p>
<hr>
<h4>Grand Total: ₹ <%= (milkTotal + productTotal) %></h4>
</div>

<div>
<div id="paidStamp" class="stamp paid">
PAID
<span>Received</span>
<span class="stamp-date" id="paidDate"></span>
</div>

<div id="unpaidStamp" class="stamp unpaid">
UNPAID
<span>Due</span>
<span class="stamp-date" id="unpaidDate"></span>
</div>
</div>
</div>

</div>

<script>
function printPDF() {
    const customerName = "<%= customerName.replaceAll("\\s+", "_") %>";
    const customerAddress = "<%= customerAddress.replaceAll("\\s+", "_") %>";
    const monthName = "<%= monthName %>";
    const year = "<%= year %>";
    document.title = customerName + "-" + customerAddress + "-" + monthName + "-" + year;
    window.print();
}

function togglePayment(type) {

    const paidStamp = document.getElementById("paidStamp");
    const unpaidStamp = document.getElementById("unpaidStamp");

    const paidDate = document.getElementById("paidDate");
    const unpaidDate = document.getElementById("unpaidDate");

    const today = new Date().toLocaleDateString("en-GB"); // DD/MM/YYYY

    if (type === "paid") {
        document.getElementById("paidCheck").checked = true;
        document.getElementById("unpaidCheck").checked = false;
        paidDate.innerText = "Date: " + today;
        paidStamp.style.display = "block";
        unpaidStamp.style.display = "none";
    }

    if (type === "unpaid") {
        document.getElementById("unpaidCheck").checked = true;
        document.getElementById("paidCheck").checked = false;
        unpaidDate.innerText = "Date: " + today;
        unpaidStamp.style.display = "block";
        paidStamp.style.display = "none";
    }
}
</script>

<% } %>

<div class="d-flex justify-content-center no-print">
<a href="dashboard.jsp" class="btn btn-secondary mt-3">← Back to Home</a>
</div>

<jsp:include page="footer.jsp" />
