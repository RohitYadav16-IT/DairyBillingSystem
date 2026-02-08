package controller;

import util.DBConnection;
import java.sql.ResultSet;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/MainServlet")
public class MainServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("jsp/error.jsp");
            return;
        }

        switch (action) {

            case "login":
                login(request, response);
                break;

            case "addCustomer":
                addCustomer(request, response);
                break;

            case "updateCustomer":
                updateCustomer(request, response);
                break;

            case "milkEntry":
                milkEntry(request, response);
                break;

            case "updateMilkEntry":
                updateMilkEntry(request, response);
                break;

            case "productEntry":
                productEntry(request, response);
                break;

            case "updateProductEntry":
                updateProductEntry(request, response);
                break;
                
            case "updateAdmin":
                updateAdmin(request, response);
                break;


            default:
                response.sendRedirect("jsp/error.jsp");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("jsp/error.jsp");
            return;
        }

        switch (action) {

            case "logout":
                logout(request, response);
                break;

            case "deleteCustomer":
                deleteCustomer(request, response);
                break;

            default:
                response.sendRedirect("jsp/error.jsp");
        }
    }


    private void login(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT * FROM admin WHERE username=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, request.getParameter("username"));
            ps.setString(2, request.getParameter("password"));

            if (ps.executeQuery().next()) {
                HttpSession session = request.getSession();
                session.setAttribute("username", request.getParameter("username"));
                response.sendRedirect("jsp/dashboard.jsp");
            } else {
                response.sendRedirect("jsp/login.jsp?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/login.jsp?error=1");
        }
    }


    private void addCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try (Connection con = DBConnection.getConnection()) {

            String sql =
                "INSERT INTO customer(name, contact, address, milk_type) VALUES (?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, request.getParameter("name"));
            ps.setString(2, request.getParameter("contact"));
            ps.setString(3, request.getParameter("address"));
            ps.setString(4, request.getParameter("milkType"));

            ps.executeUpdate();
            response.sendRedirect("jsp/entry.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/error.jsp");
        }
    }


    private void updateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try (Connection con = DBConnection.getConnection()) {

            String sql =
                "UPDATE customer SET name=?, contact=?, address=?, milk_type=? WHERE customer_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, request.getParameter("name"));
            ps.setString(2, request.getParameter("contact"));
            ps.setString(3, request.getParameter("address"));
            ps.setString(4, request.getParameter("milkType"));
            ps.setInt(5, Integer.parseInt(request.getParameter("customerId")));

            ps.executeUpdate();
            response.sendRedirect("jsp/viewCustomers.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/error.jsp");
        }
    }


    private void milkEntry(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        try (Connection con = DBConnection.getConnection()) {

            int customerId = Integer.parseInt(req.getParameter("customerId"));

            String cowQtyStr = req.getParameter("cowQty");
            String buffaloQtyStr = req.getParameter("buffaloQty");

            if (cowQtyStr != null && !cowQtyStr.isEmpty()) {
                double cowQty = Double.parseDouble(cowQtyStr);
                if (cowQty > 0) insertMilk(con, customerId, "Cow", cowQty, 60);
            }

            if (buffaloQtyStr != null && !buffaloQtyStr.isEmpty()) {
                double buffaloQty = Double.parseDouble(buffaloQtyStr);
                if (buffaloQty > 0) insertMilk(con, customerId, "Buffalo", buffaloQty, 74);
            }

            res.sendRedirect("jsp/entry.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("jsp/error.jsp");
        }
    }

    private void insertMilk(Connection con, int customerId,
                            String milkType, double qty, double rate) throws Exception {

        String sql =
            "INSERT INTO milk_entry " +
            "(customer_id, milk_type, quantity_liters, rate_per_liter, entry_date) " +
            "VALUES (?,?,?,?,CURDATE())";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, customerId);
        ps.setString(2, milkType);
        ps.setDouble(3, qty);
        ps.setDouble(4, rate);

        ps.executeUpdate();
    }


    private void updateMilkEntry(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try (Connection con = DBConnection.getConnection()) {

            String sql =
                "UPDATE milk_entry SET quantity_liters=?, rate_per_liter=? WHERE milk_entry_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDouble(1, Double.parseDouble(request.getParameter("quantity")));
            ps.setDouble(2, Double.parseDouble(request.getParameter("rate")));
            ps.setInt(3, Integer.parseInt(request.getParameter("milkEntryId")));

            ps.executeUpdate();
            response.sendRedirect("jsp/viewCustomers.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/error.jsp");
        }
    }


    private void productEntry(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try (Connection con = DBConnection.getConnection()) {

            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String productName = request.getParameter("productName");

            int kg = Integer.parseInt(request.getParameter("kg"));
            int grams = Integer.parseInt(request.getParameter("grams"));
            double rate = Double.parseDouble(request.getParameter("rate"));

            double totalKg = kg + (grams / 1000.0);

            String sql =
                "INSERT INTO product " +
                "(customer_id, product_name, quantity_kg, rate_per_kg, entry_date) " +
                "VALUES (?,?,?,?,CURDATE())";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, customerId);
            ps.setString(2, productName);
            ps.setDouble(3, totalKg);
            ps.setDouble(4, rate);

            ps.executeUpdate();
            response.sendRedirect("jsp/entry.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/error.jsp");
        }
    }


    private void updateProductEntry(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try (Connection con = DBConnection.getConnection()) {

            String sql =
                "UPDATE product SET quantity_kg=?, rate_per_kg=? WHERE product_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDouble(1, Double.parseDouble(request.getParameter("quantity")));
            ps.setDouble(2, Double.parseDouble(request.getParameter("rate")));
            ps.setInt(3, Integer.parseInt(request.getParameter("productId")));

            ps.executeUpdate();
            response.sendRedirect("jsp/viewCustomers.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/error.jsp");
        }
    }


    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try (Connection con = DBConnection.getConnection()) {

            int customerId = Integer.parseInt(request.getParameter("customerId"));

            PreparedStatement ps1 =
                con.prepareStatement("DELETE FROM milk_entry WHERE customer_id=?");
            ps1.setInt(1, customerId);
            ps1.executeUpdate();

            PreparedStatement ps2 =
                con.prepareStatement("DELETE FROM product WHERE customer_id=?");
            ps2.setInt(1, customerId);
            ps2.executeUpdate();

            PreparedStatement ps3 =
                con.prepareStatement("DELETE FROM customer WHERE customer_id=?");
            ps3.setInt(1, customerId);
            ps3.executeUpdate();

            response.sendRedirect("jsp/viewCustomers.jsp?success=deleted");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/error.jsp");
        }
    }


    private void logout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("jsp/login.jsp");
    }
    
    private void updateAdmin(HttpServletRequest request,
            HttpServletResponse response)
throws IOException {

try (Connection con = DBConnection.getConnection()) {

HttpSession session = request.getSession();
String currentUsername = (String) session.getAttribute("username");

String newUsername = request.getParameter("username");
String oldPassword = request.getParameter("oldPassword");
String newPassword = request.getParameter("newPassword");

String checkSql =
"SELECT * FROM admin WHERE username=? AND password=?";

PreparedStatement checkPs = con.prepareStatement(checkSql);
checkPs.setString(1, currentUsername);
checkPs.setString(2, oldPassword);

ResultSet rs = checkPs.executeQuery();

if (!rs.next()) {
response.sendRedirect("jsp/updateAdmin.jsp?error=invalid");
return;
}

String updateSql =
"UPDATE admin SET username=?, password=? WHERE username=?";

PreparedStatement ps = con.prepareStatement(updateSql);
ps.setString(1, newUsername);
ps.setString(2, newPassword);
ps.setString(3, currentUsername);

ps.executeUpdate();

session.setAttribute("username", newUsername);

response.sendRedirect("jsp/dashboard.jsp");

} catch (Exception e) {
e.printStackTrace();
response.sendRedirect("jsp/error.jsp");
}
}


}
