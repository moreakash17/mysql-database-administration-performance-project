-- ============================================================
-- SQL Troubleshooting & Query Optimization Practice
-- Database: MySQL 8.x
-- ============================================================

DROP DATABASE IF EXISTS sql_practice;
CREATE DATABASE sql_practice;
USE sql_practice;

-- ============================================================
-- 1. CREATE PRACTICE TABLES
-- ============================================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    city VARCHAR(80),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(80) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    stock_qty INT NOT NULL DEFAULT 0,
    active BOOLEAN DEFAULT TRUE,
    CONSTRAINT chk_product_price CHECK (unit_price >= 0),
    CONSTRAINT chk_product_stock CHECK (stock_qty >= 0)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status ENUM('Pending','Shipped','Delivered','Cancelled') DEFAULT 'Pending',
    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_item_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_item_product
        FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT chk_item_quantity CHECK (quantity > 0),
    CONSTRAINT chk_item_price CHECK (unit_price >= 0)
);

-- ============================================================
-- 2. SAMPLE DATA
-- ============================================================

INSERT INTO customers (customer_name, email, city) VALUES
('Amit Sharma','amit@example.com','Pune'),
('Priya Patil','priya@example.com','Mumbai'),
('Rahul More','rahul@example.com','Nashik'),
('Sneha Joshi','sneha@example.com','Pune'),
('Vikas Kale','vikas@example.com','Nagpur'),
('Neha Deshmukh','neha@example.com','Mumbai'),
('Rohit Jadhav','rohit@example.com','Pune'),
('Pooja Kulkarni','pooja@example.com','Nashik');

INSERT INTO products (product_name, category, unit_price, stock_qty, active) VALUES
('Laptop','Electronics',65000,25,TRUE),
('Keyboard','Electronics',1800,100,TRUE),
('Mouse','Electronics',900,150,TRUE),
('Monitor','Electronics',12000,45,TRUE),
('Office Chair','Furniture',8500,30,TRUE),
('Desk','Furniture',15000,20,TRUE),
('Notebook','Stationery',120,300,TRUE),
('Pen Pack','Stationery',250,250,TRUE),
('Old Printer','Electronics',8500,0,FALSE);

INSERT INTO orders (customer_id, order_date, status) VALUES
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

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
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

-- ============================================================
-- 3. BASIC DATABASE VALIDATION
-- ============================================================

SHOW DATABASES;
SELECT DATABASE();
SHOW TABLES;

SELECT COUNT(*) AS customer_count FROM customers;
SELECT COUNT(*) AS product_count FROM products;
SELECT COUNT(*) AS order_count FROM orders;
SELECT COUNT(*) AS order_item_count FROM order_items;

-- ============================================================
-- 4. SQL TROUBLESHOOTING EXAMPLES
-- ============================================================

-- ERROR EXAMPLE A: No database selected
-- If you run this before selecting a database, MySQL may return:
-- ERROR 1046 (3D000): No database selected
-- FIX:
USE sql_practice;
SELECT * FROM customers;

-- ERROR EXAMPLE B: Invalid column name
-- Incorrect example (do not execute):
-- SELECT customer_name, phone FROM customers;
-- FIX: verify columns first.
DESCRIBE customers;
SELECT customer_name, email FROM customers;

-- ERROR EXAMPLE C: Missing comma / malformed SELECT
-- Incorrect example (do not execute):
-- SELECT customer_id customer_name email FROM customers;
-- FIX:
SELECT customer_id, customer_name, email FROM customers;

-- ERROR EXAMPLE D: Incorrect table name
-- Incorrect example (do not execute):
-- SELECT * FROM customer;
-- FIX:
SHOW TABLES;
SELECT * FROM customers;

-- ERROR EXAMPLE E: Incorrect WHERE comparison
-- Incorrect example (do not execute):
-- SELECT * FROM products WHERE active = 'YES';
-- FIX: active is BOOLEAN.
SELECT * FROM products WHERE active = TRUE;

-- ERROR EXAMPLE F: Aggregate query issue
-- Incorrect example (do not execute):
-- SELECT city, customer_name, COUNT(*) FROM customers GROUP BY city;
-- FIX: group by all non-aggregated selected columns, or aggregate customer_name appropriately.
SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city;

-- ============================================================
-- 5. DATA INTEGRITY TROUBLESHOOTING
-- ============================================================

-- Find NULL emails.
SELECT *
FROM customers
WHERE email IS NULL;

-- Find duplicate emails.
SELECT email, COUNT(*) AS duplicate_count
FROM customers
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;

-- Find invalid/negative product values.
SELECT *
FROM products
WHERE unit_price < 0 OR stock_qty < 0;

-- Find invalid order quantities/prices.
SELECT *
FROM order_items
WHERE quantity <= 0 OR unit_price < 0;

-- Check orphan order records. With a foreign key this should return zero rows.
SELECT o.*
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- ============================================================
-- 6. FILTERING AND QUERY RESTRUCTURING
-- ============================================================

-- Prefer selecting only required columns instead of SELECT * when possible.
SELECT product_id, product_name, unit_price
FROM products
WHERE category = 'Electronics'
  AND active = TRUE;

-- Date filtering.
SELECT order_id, customer_id, order_date, status
FROM orders
WHERE order_date >= '2026-02-01'
  AND order_date < '2026-04-01';

-- Use IN for multiple equality conditions.
SELECT *
FROM customers
WHERE city IN ('Pune','Mumbai');

-- ============================================================
-- 7. JOIN TROUBLESHOOTING AND OPTIMIZATION BASICS
-- ============================================================

-- Customer orders.
SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.status
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY o.order_date DESC;

-- Product sales summary excluding cancelled orders.
SELECT
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id
INNER JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.status <> 'Cancelled'
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC;

-- Customer spending summary.
SELECT
    c.customer_id,
    c.customer_name,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_spend
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
   AND o.status <> 'Cancelled'
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spend DESC;

-- ============================================================
-- 8. INDEXING AND EXPLAIN
-- ============================================================

-- Baseline query plan.
EXPLAIN
SELECT order_id, order_date, status
FROM orders
WHERE customer_id = 1
ORDER BY order_date DESC;

-- Add indexes for frequently filtered/joined columns.
CREATE INDEX idx_orders_customer_date
ON orders(customer_id, order_date);

CREATE INDEX idx_orders_status
ON orders(status);

CREATE INDEX idx_order_items_order
ON order_items(order_id);

CREATE INDEX idx_order_items_product
ON order_items(product_id);

CREATE INDEX idx_products_category_active
ON products(category, active);

-- Inspect indexes.
SHOW INDEX FROM orders;
SHOW INDEX FROM order_items;
SHOW INDEX FROM products;

-- Analyze the query plan after indexing.
EXPLAIN
SELECT order_id, order_date, status
FROM orders
WHERE customer_id = 1
ORDER BY order_date DESC;

-- Another indexed lookup example.
EXPLAIN
SELECT product_id, product_name, unit_price
FROM products
WHERE category = 'Electronics'
  AND active = TRUE;

-- Refresh optimizer statistics when appropriate.
ANALYZE TABLE customers, products, orders, order_items;

-- ============================================================
-- 9. TRANSACTION TROUBLESHOOTING
-- ============================================================

-- Test ROLLBACK.
START TRANSACTION;

UPDATE products
SET stock_qty = stock_qty - 2
WHERE product_id = 1
  AND stock_qty >= 2;

SELECT product_id, product_name, stock_qty
FROM products
WHERE product_id = 1;

ROLLBACK;

-- Confirm the rollback restored the previous value.
SELECT product_id, product_name, stock_qty
FROM products
WHERE product_id = 1;

-- Test COMMIT.
START TRANSACTION;

UPDATE products
SET stock_qty = stock_qty - 1
WHERE product_id = 2
  AND stock_qty >= 1;

COMMIT;

SELECT product_id, product_name, stock_qty
FROM products
WHERE product_id = 2;

-- ============================================================
-- 10. USER AND PERMISSION SCENARIOS
-- ============================================================

-- Practice only. Uncomment and change the password before use.
-- CREATE USER 'sql_readonly'@'localhost' IDENTIFIED BY 'ChangeThisPassword!';
-- GRANT SELECT ON sql_practice.* TO 'sql_readonly'@'localhost';
-- SHOW GRANTS FOR 'sql_readonly'@'localhost';
-- REVOKE SELECT ON sql_practice.* FROM 'sql_readonly'@'localhost';
-- DROP USER 'sql_readonly'@'localhost';

-- Check current user and privileges.
SELECT CURRENT_USER();
SHOW GRANTS;

-- ============================================================
-- 11. BACKUP AND RECOVERY PRACTICE
-- ============================================================

-- Run these commands in a system terminal, not as SQL statements in Workbench.
-- Backup:
-- mysqldump -u root -p sql_practice > sql_practice_backup.sql
-- Restore into a new database after creating it:
-- mysql -u root -p sql_practice < sql_practice_backup.sql

-- ============================================================
-- 12. DATABASE HEALTH CHECKS
-- ============================================================

SELECT VERSION() AS mysql_version;
SELECT DATABASE() AS current_database;

SELECT
    TABLE_NAME,
    TABLE_ROWS,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_mb,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_mb
FROM information_schema.tables
WHERE table_schema = 'sql_practice';

-- Check table definitions.
SHOW CREATE TABLE customers;
SHOW CREATE TABLE products;
SHOW CREATE TABLE orders;
SHOW CREATE TABLE order_items;

-- ============================================================
-- END OF PROJECT
-- ============================================================
