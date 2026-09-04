-- MySQL Database Administration & Performance Project
-- Project: RetailDB

DROP DATABASE IF EXISTS retaildb;
CREATE DATABASE retaildb;
USE retaildb;

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    department_id INT NOT NULL,
    salary DECIMAL(12,2) NOT NULL,
    hire_date DATE NOT NULL,
    status ENUM('Active','Inactive') DEFAULT 'Active',
    CONSTRAINT fk_employee_department
        FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(120) NOT NULL,
    email VARCHAR(120) UNIQUE,
    city VARCHAR(80),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(120) NOT NULL,
    category VARCHAR(80) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    stock_qty INT NOT NULL DEFAULT 0,
    active BOOLEAN DEFAULT TRUE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status ENUM('Pending','Shipped','Delivered','Cancelled') DEFAULT 'Pending',
    CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_item_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_item_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO departments (department_name) VALUES
('IT'),('Sales'),('HR'),('Finance'),('Operations');

INSERT INTO employees
(first_name,last_name,email,department_id,salary,hire_date,status) VALUES
('Amit','Sharma','amit@example.com',1,65000,'2023-01-15','Active'),
('Priya','Patil','priya@example.com',2,58000,'2022-06-10','Active'),
('Rahul','More','rahul@example.com',1,72000,'2021-03-20','Active'),
('Sneha','Joshi','sneha@example.com',3,52000,'2024-02-12','Active'),
('Vikas','Kale','vikas@example.com',4,68000,'2020-11-05','Active'),
('Neha','Deshmukh','neha@example.com',5,56000,'2023-08-18','Inactive'),
('Rohit','Jadhav','rohit@example.com',2,61000,'2022-09-01','Active'),
('Pooja','Kulkarni','pooja@example.com',3,54000,'2024-04-22','Active');

INSERT INTO customers (customer_name,email,city) VALUES
('Customer A','a@example.com','Pune'),
('Customer B','b@example.com','Mumbai'),
('Customer C','c@example.com','Nashik'),
('Customer D','d@example.com','Pune'),
('Customer E','e@example.com','Nagpur'),
('Customer F','f@example.com','Mumbai');

INSERT INTO products (product_name,category,unit_price,stock_qty) VALUES
('Laptop','Electronics',65000,25),
('Keyboard','Electronics',1800,100),
('Mouse','Electronics',900,150),
('Monitor','Electronics',12000,45),
('Office Chair','Furniture',8500,30),
('Desk','Furniture',15000,20),
('Notebook','Stationery',120,300),
('Pen Pack','Stationery',250,250);

INSERT INTO orders (customer_id,order_date,status) VALUES
(1,'2026-01-05','Delivered'),
(2,'2026-01-08','Delivered'),
(3,'2026-01-12','Shipped'),
(4,'2026-02-02','Delivered'),
(5,'2026-02-11','Pending'),
(6,'2026-02-15','Delivered'),
(1,'2026-03-03','Delivered'),
(2,'2026-03-10','Cancelled'),
(3,'2026-03-14','Delivered'),
(4,'2026-03-18','Shipped');

INSERT INTO order_items (order_id,product_id,quantity,unit_price) VALUES
(1,1,1,65000),(1,2,2,1800),
(2,4,2,12000),(2,3,2,900),
(3,5,2,8500),(3,6,1,15000),
(4,1,1,65000),(4,3,1,900),
(5,7,20,120),
(6,6,2,15000),(6,5,2,8500),
(7,4,1,12000),(7,2,3,1800),
(8,1,1,65000),
(9,5,1,8500),(9,3,4,900),
(10,2,5,1800),(10,7,10,120);

CREATE OR REPLACE VIEW vw_order_sales AS
SELECT o.order_id, o.order_date, o.status, c.customer_name, c.city,
       p.product_name, p.category, oi.quantity, oi.unit_price,
       oi.quantity * oi.unit_price AS line_total
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

SELECT * FROM vw_order_sales;

SELECT department_id, COUNT(*) AS employee_count,
       ROUND(AVG(salary),2) AS avg_salary
FROM employees GROUP BY department_id;

SELECT p.product_name, SUM(oi.quantity) AS units_sold,
       SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status <> 'Cancelled'
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC;

SELECT c.customer_name, SUM(oi.quantity * oi.unit_price) AS total_spend
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status <> 'Cancelled'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spend DESC;

CREATE INDEX idx_employees_department ON employees(department_id);
CREATE INDEX idx_employees_hire_date ON employees(hire_date);
CREATE INDEX idx_orders_customer_date ON orders(customer_id, order_date);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_order_items_product ON order_items(product_id);
CREATE INDEX idx_products_category ON products(category);

SHOW INDEX FROM employees;
SHOW INDEX FROM orders;
SHOW INDEX FROM order_items;

EXPLAIN
SELECT o.order_id, o.order_date, c.customer_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.customer_id = 1
ORDER BY o.order_date DESC;

START TRANSACTION;
UPDATE products
SET stock_qty = stock_qty - 2
WHERE product_id = 1 AND stock_qty >= 2;
SELECT product_id, product_name, stock_qty FROM products WHERE product_id = 1;
ROLLBACK;

START TRANSACTION;
UPDATE products
SET stock_qty = stock_qty - 1
WHERE product_id = 2 AND stock_qty >= 1;
COMMIT;

DELIMITER //
CREATE PROCEDURE GetCustomerOrders(IN p_customer_id INT)
BEGIN
    SELECT o.order_id, o.order_date, o.status,
           SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.customer_id = p_customer_id
    GROUP BY o.order_id, o.order_date, o.status
    ORDER BY o.order_date DESC;
END //
DELIMITER ;

CALL GetCustomerOrders(1);

-- Backup: mysqldump -u root -p retaildb > retaildb_backup.sql
-- Restore: mysql -u root -p retaildb < retaildb_backup.sql

SHOW DATABASES;
SHOW TABLES;
SELECT VERSION();
SELECT TABLE_NAME, TABLE_ROWS
FROM information_schema.tables
WHERE table_schema = 'retaildb';

-- Security practice:
-- CREATE USER 'retail_readonly'@'localhost' IDENTIFIED BY 'ChangeThisPassword!';
-- GRANT SELECT ON retaildb.* TO 'retail_readonly'@'localhost';
-- SHOW GRANTS FOR 'retail_readonly'@'localhost';
-- REVOKE SELECT ON retaildb.* FROM 'retail_readonly'@'localhost';
-- DROP USER 'retail_readonly'@'localhost';
