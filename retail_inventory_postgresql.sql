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


-- Total Sales Per Product
SELECT 
    p.product_name,
    SUM(od.quantity) AS total_units_sold,
    SUM(od.total_price) AS total_sales
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC;


-- Low Stock Alert

SELECT product_name, stock_quantity
FROM Products
WHERE stock_quantity < 10;


-- Customer Purchase History

SELECT 
    c.customer_name,
    o.order_date,
    p.product_name,
    od.quantity,
    od.total_price
FROM Orders o
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
JOIN Customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC;

