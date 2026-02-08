package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/DairyBillingSystem";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    public static Connection getConnection() {
        Connection connection = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("JDBC Driver not found");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Unable to connect to the database");
            e.printStackTrace();
        }

        return connection;
    }

    public static void main(String[] args) {
        if (getConnection() != null) {
            System.out.println("Database connected successfully");
        } else {
            System.out.println("Database connection failed");
        }
    }
}
