# Web-Based Customer and Entry Management System

A Java web application built using **JSP, Servlets, JDBC, and MySQL** to manage customers, entries, and administrative operations.  
The system allows secure login, data entry, updates, and report generation through an MVC-based architecture.

---

## 🚀 Features

- Admin authentication (login/logout)
- Add new customer entries
- View customer list
- Update customer details
- Update existing entries
- Generate reports
- Session-based access control
- Centralized error handling

---

## 🧱 Architecture

The application follows **MVC (Model-View-Controller)**.

- **Model** → Database + JDBC  
- **View** → JSP pages  
- **Controller** → MainServlet  

---

## 🛠️ Tech Stack

| Layer | Technology |
|------|-----------|
| Frontend | HTML, CSS, JSP |
| Backend | Java Servlet |
| Database | MySQL |
| Connectivity | JDBC |
| Server | Apache Tomcat |

---
## ⚙️ Setup & Installation
```bash
1. Clone the repository

git clone https://github.com/yourusername/your-repo-name.git

2. Open in IDE

Import into Eclipse / IntelliJ as a Dynamic Web Project.

3. Configure Tomcat

Add Apache Tomcat server and run the project.

4. Create Database

Run the SQL given below in MySQL.

5. Update DB credentials

Edit inside DBConnection.java:

private static final String URL = "jdbc:mysql://localhost:3306/your_db";
private static final String USER = "root";
private static final String PASS = "password";

🗄️ Database Schema (IMPORTANT)
Create Database
CREATE DATABASE customer_entry_db;
USE customer_entry_db;


Admin Table
CREATE TABLE admin (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL
);

INSERT INTO admin (username, password)
VALUES ('admin', 'admin123');


Customers Table
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(255)
);


Entries Table
CREATE TABLE entries (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    entry_date DATE,
    amount DOUBLE,
    description VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
        ON DELETE CASCADE
);

