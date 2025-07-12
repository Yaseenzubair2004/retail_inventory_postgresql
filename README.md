# Retail_inventory_postgresql
A mini PostgreSQL project to simulate retail sales, inventory, supplier purchases, and profit analysis using SQL.

# 📊 Retail Sales and Inventory Management System (PostgreSQL)

A mini PostgreSQL project to simulate retail sales, inventory, supplier purchases, and profit analysis using SQL.

## 📁 Project Structure

- **retail_inventory_postgresql.sql** – Complete schema, sample inserts, and queries.

## 🧱 Database Schema

- `Products`: Items for sale
- `Customers`: Buyer info
- `Orders` and `OrderDetails`: Transactions
- `Suppliers` and `Purchases`: Inventory sourcing

## 🔍 Key Features

✅ Analyze total sales per product  
✅ Track customer purchase history  
✅ Monitor low stock alerts  
✅ Calculate profit using sales and purchase data


# Retail Sales and Inventory Management System 📊

A PostgreSQL-based project to manage and analyze retail sales, product inventory, suppliers, and customers.

## 📁 Schema Overview

- **Products:** Stores product details and stock levels.
- **Customers:** Customer profiles.
- **Orders & OrderDetails:** Records of customer orders.
- **Suppliers & Purchases:** Supplier and purchase tracking.

## 📊 Key SQL Queries

- Total Sales Per Product
- Profit Analysis (Sales - Purchase Cost)
- Low Stock Alert
- Customer Purchase History

## 🚀 How to Use

1. Run the SQL file in pgAdmin or any PostgreSQL environment.
2. Modify or expand the database with your own data.
3. Analyze using SQL or connect to Power BI/Python.

## 📌 Author

- **Yaseen** – [GitHub Profile](https://github.com/Yaseenzubair2004)


## 📊 Sample SQL Queries
-- PostgreSQL Retail Sales and Inventory Management Project

-- 1. Create Tables
CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT
);

CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customers(customer_id),
    order_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE OrderDetails (
    order_detail_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES Orders(order_id),
    product_id INT REFERENCES Products(product_id),
    quantity INT,
    total_price DECIMAL(10, 2)
);

CREATE TABLE Suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(100),
    contact_info VARCHAR(100)
);

CREATE TABLE Purchases (
    purchase_id SERIAL PRIMARY KEY,
    supplier_id INT REFERENCES Suppliers(supplier_id),
    product_id INT REFERENCES Products(product_id),
    quantity INT,
    purchase_price DECIMAL(10, 2),
    purchase_date DATE DEFAULT CURRENT_DATE
);


-- Sample Data for Products
INSERT INTO Products (product_name, category, price, stock_quantity) VALUES ('Laptop', 'Electronics', 60000, 20);
INSERT INTO Products (product_name, category, price, stock_quantity) VALUES ('Smartphone', 'Electronics', 25000, 50);
INSERT INTO Products (product_name, category, price, stock_quantity) VALUES ('Office Chair', 'Furniture', 5000, 15);
INSERT INTO Products (product_name, category, price, stock_quantity) VALUES ('Notebook', 'Stationery', 50, 500);
INSERT INTO Products (product_name, category, price, stock_quantity) VALUES ('Pen', 'Stationery', 10, 1000);

-- Sample Data for Customers
INSERT INTO Customers (customer_name, email, phone) VALUES ('Rahul Sharma', 'rahul@example.com', '9876543210');
INSERT INTO Customers (customer_name, email, phone) VALUES ('Ananya Verma', 'ananya@example.com', '9123456780');
INSERT INTO Customers (customer_name, email, phone) VALUES ('John Doe', 'john@example.com', '9988776655');

-- Sample Data for Suppliers
INSERT INTO Suppliers (supplier_name, contact_info) VALUES ('ElectroWorld', 'contact@electroworld.com');
INSERT INTO Suppliers (supplier_name, contact_info) VALUES ('OfficeNeeds', 'support@officeneeds.com');
INSERT INTO Suppliers (supplier_name, contact_info) VALUES ('StatPro', 'info@statpro.com');


-- Sample Data for Orders
INSERT INTO Orders (customer_id, order_date) VALUES (1, '2025-06-15');
INSERT INTO Orders (customer_id, order_date) VALUES (2, '2025-06-16');
INSERT INTO Orders (customer_id, order_date) VALUES (3, '2025-06-17');

-- Sample Data for OrderDetails
INSERT INTO OrderDetails (order_id, product_id, quantity, total_price) VALUES (1, 1, 2, 50000);
INSERT INTO OrderDetails (order_id, product_id, quantity, total_price) VALUES (1, 4, 5, 250);
INSERT INTO OrderDetails (order_id, product_id, quantity, total_price) VALUES (2, 2, 1, 60000);
INSERT INTO OrderDetails (order_id, product_id, quantity, total_price) VALUES (3, 3, 2, 10000);
INSERT INTO OrderDetails (order_id, product_id, quantity, total_price) VALUES (3, 5, 10, 100);

-- Sample Data for Purchases
INSERT INTO Purchases (supplier_id, product_id, quantity, purchase_price, purchase_date) VALUES (1, 1, 10, 50000, '2025-06-10');
INSERT INTO Purchases (supplier_id, product_id, quantity, purchase_price, purchase_date) VALUES (2, 2, 20, 4000, '2025-06-11');
INSERT INTO Purchases (supplier_id, product_id, quantity, purchase_price, purchase_date) VALUES (3, 5, 200, 5, '2025-06-12');


2. Sample Query: Total Sales Per Product
SELECT 
    p.product_name,
    SUM(od.quantity) AS total_units_sold,
    SUM(od.total_price) AS total_sales
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC;

