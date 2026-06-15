## Dairy Billing System

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
CREATE DATABASE DairyBillingSystem;
USE DairyBillingSystem;

CREATE TABLE admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact VARCHAR(20),
    address TEXT,
    milk_type VARCHAR(20) NOT NULL
);

CREATE TABLE milk_entry (
    milk_entry_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    milk_type VARCHAR(20) NOT NULL,
    quantity_liters DECIMAL(10,2) NOT NULL,
    rate_per_liter DECIMAL(10,2) NOT NULL,
    entry_date DATE NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id)
        ON DELETE CASCADE
);

CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    quantity_kg DECIMAL(10,3) NOT NULL,
    rate_per_kg DECIMAL(10,2) NOT NULL,
    entry_date DATE NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id)
        ON DELETE CASCADE
);

INSERT INTO admin(username,password)
VALUES ('admin','admin123');

```
<img width="1918" height="920" alt="image" src="https://github.com/user-attachments/assets/3364df65-2c3b-4695-8c5f-98f14ebf8520" />

<img width="1918" height="917" alt="image" src="https://github.com/user-attachments/assets/0a6f913f-f1f0-43b2-8869-82977d84deeb" />

<img width="1917" height="715" alt="image" src="https://github.com/user-attachments/assets/33670c3f-ac4d-4ffc-9f80-4d25467ede75" />

<img width="1917" height="582" alt="image" src="https://github.com/user-attachments/assets/e252ee46-c39d-48ec-b45e-9c045c763eb2" />

<img width="1918" height="700" alt="image" src="https://github.com/user-attachments/assets/ebdc87bc-e879-45ca-82a8-5471c2e77ba9" />

<img width="1918" height="693" alt="image" src="https://github.com/user-attachments/assets/63375820-cfe2-46bc-83db-1a06079c1c7c" />

<img width="1897" height="911" alt="image" src="https://github.com/user-attachments/assets/c84dc104-b938-4809-b3f2-7cf8804f98e1" />

<img width="1917" height="911" alt="image" src="https://github.com/user-attachments/assets/0e351ba3-ff2e-410f-91c6-15900ae73760" />










