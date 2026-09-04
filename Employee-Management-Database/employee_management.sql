-- Employee Management Database
-- MySQL / SQL Portfolio Project
-- Demonstrates relational design, normalization, constraints and analytical queries.

DROP DATABASE IF EXISTS employee_management;
CREATE DATABASE employee_management;
USE employee_management;

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100) NOT NULL
);

CREATE TABLE roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(100) NOT NULL UNIQUE,
    min_salary DECIMAL(12,2) NOT NULL,
    max_salary DECIMAL(12,2) NOT NULL,
    CHECK (min_salary <= max_salary)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    phone VARCHAR(20) UNIQUE,
    department_id INT NOT NULL,
    role_id INT NOT NULL,
    manager_id INT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(12,2) NOT NULL,
    performance_rating DECIMAL(3,1) DEFAULT 3.0,
    employment_status ENUM('Active','Inactive','On Leave') DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_employee_department FOREIGN KEY (department_id) REFERENCES departments(department_id),
    CONSTRAINT fk_employee_role FOREIGN KEY (role_id) REFERENCES roles(role_id),
    CONSTRAINT fk_employee_manager FOREIGN KEY (manager_id) REFERENCES employees(employee_id),
    CHECK (salary > 0),
    CHECK (performance_rating BETWEEN 1.0 AND 5.0)
);

INSERT INTO departments (department_name, location) VALUES
('IT','Pune'),
('Finance','Mumbai'),
('Human Resources','Pune'),
('Sales','Mumbai'),
('Operations','Nashik'),
('Marketing','Pune');

INSERT INTO roles (role_name, min_salary, max_salary) VALUES
('Software Engineer',45000,120000),
('Data Analyst',40000,100000),
('Database Administrator',50000,130000),
('HR Executive',35000,80000),
('Financial Analyst',45000,110000),
('Sales Executive',30000,90000),
('Operations Manager',60000,140000),
('Marketing Executive',35000,85000);

INSERT INTO employees
(first_name,last_name,email,phone,department_id,role_id,manager_id,hire_date,salary,performance_rating,employment_status)
VALUES
('Amit','Sharma','amit.sharma@example.com','9000000001',1,1,NULL,'2021-01-15',95000,4.6,'Active'),
('Priya','Patil','priya.patil@example.com','9000000002',1,2,1,'2022-03-10',72000,4.4,'Active'),
('Rahul','More','rahul.more@example.com','9000000003',1,3,1,'2020-07-20',105000,4.8,'Active'),
('Sneha','Joshi','sneha.joshi@example.com','9000000004',3,4,NULL,'2023-02-12',52000,4.1,'Active'),
('Vikas','Kale','vikas.kale@example.com','9000000005',2,5,NULL,'2019-11-05',88000,4.3,'Active'),
('Neha','Deshmukh','neha.deshmukh@example.com','9000000006',4,6,NULL,'2024-01-18',48000,3.8,'Active'),
('Rohit','Jadhav','rohit.jadhav@example.com','9000000007',4,6,6,'2022-09-01',55000,4.0,'Active'),
('Pooja','Kulkarni','pooja.kulkarni@example.com','9000000008',3,4,4,'2024-04-22',50000,4.2,'Active'),
('Karan','Pawar','karan.pawar@example.com','9000000009',5,7,NULL,'2018-06-14',115000,4.7,'Active'),
('Meera','Shinde','meera.shinde@example.com','9000000010',6,8,NULL,'2023-08-18',58000,3.9,'Active'),
('Suresh','Gaikwad','suresh.gaikwad@example.com','9000000011',1,1,1,'2025-01-06',65000,3.7,'Active'),
('Anjali','Bhosale','anjali.bhosale@example.com','9000000012',2,5,5,'2021-10-11',76000,4.5,'On Leave');

-- Basic employee report
SELECT employee_id, CONCAT(first_name,' ',last_name) AS employee_name,
       email, salary, hire_date, employment_status
FROM employees
ORDER BY employee_id;

-- Department-wise employee count and average salary
SELECT d.department_name,
       COUNT(e.employee_id) AS employee_count,
       ROUND(AVG(e.salary),2) AS average_salary,
       ROUND(MAX(e.salary),2) AS highest_salary,
       ROUND(MIN(e.salary),2) AS lowest_salary
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY average_salary DESC;

-- Role-wise employee statistics
SELECT r.role_name,
       COUNT(e.employee_id) AS employee_count,
       ROUND(AVG(e.salary),2) AS average_salary
FROM roles r
LEFT JOIN employees e ON r.role_id = e.role_id
GROUP BY r.role_id, r.role_name
ORDER BY employee_count DESC;

-- Employees earning above company average
SELECT employee_id,
       CONCAT(first_name,' ',last_name) AS employee_name,
       salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;

-- Experience calculation
SELECT employee_id,
       CONCAT(first_name,' ',last_name) AS employee_name,
       hire_date,
       TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS experience_years
FROM employees
ORDER BY experience_years DESC;

-- High performers
SELECT employee_id,
       CONCAT(first_name,' ',last_name) AS employee_name,
       performance_rating,
       salary
FROM employees
WHERE performance_rating >= 4.5
ORDER BY performance_rating DESC, salary DESC;

-- Department performance report
SELECT d.department_name,
       COUNT(e.employee_id) AS employees,
       ROUND(AVG(e.performance_rating),2) AS avg_performance,
       ROUND(AVG(e.salary),2) AS avg_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY avg_performance DESC;

-- Employee with department and role
SELECT e.employee_id,
       CONCAT(e.first_name,' ',e.last_name) AS employee_name,
       d.department_name,
       r.role_name,
       e.salary,
       e.performance_rating
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN roles r ON e.role_id = r.role_id
ORDER BY d.department_name, e.salary DESC;

-- Manager and direct reports
SELECT CONCAT(m.first_name,' ',m.last_name) AS manager_name,
       CONCAT(e.first_name,' ',e.last_name) AS employee_name
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
ORDER BY manager_name, employee_name;

-- Salary band validation against role range
SELECT e.employee_id,
       CONCAT(e.first_name,' ',e.last_name) AS employee_name,
       r.role_name,
       e.salary,
       r.min_salary,
       r.max_salary,
       CASE
           WHEN e.salary BETWEEN r.min_salary AND r.max_salary THEN 'Within Range'
           ELSE 'Outside Range'
       END AS salary_status
FROM employees e
JOIN roles r ON e.role_id = r.role_id;

-- Indexes for common filtering and joins
CREATE INDEX idx_employee_department ON employees(department_id);
CREATE INDEX idx_employee_role ON employees(role_id);
CREATE INDEX idx_employee_hire_date ON employees(hire_date);
CREATE INDEX idx_employee_salary ON employees(salary);
CREATE INDEX idx_employee_performance ON employees(performance_rating);

-- Query plan analysis
EXPLAIN
SELECT e.employee_id, e.first_name, e.last_name, e.salary
FROM employees e
WHERE e.department_id = 1
  AND e.salary > 70000
ORDER BY e.salary DESC;

-- Useful view for reporting
CREATE OR REPLACE VIEW vw_employee_directory AS
SELECT e.employee_id,
       CONCAT(e.first_name,' ',e.last_name) AS employee_name,
       e.email,
       d.department_name,
       r.role_name,
       e.salary,
       e.hire_date,
       TIMESTAMPDIFF(YEAR,e.hire_date,CURDATE()) AS experience_years,
       e.performance_rating,
       e.employment_status
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN roles r ON e.role_id = r.role_id;

SELECT * FROM vw_employee_directory;

-- Transaction practice
START TRANSACTION;
UPDATE employees
SET salary = salary + 5000
WHERE employee_id = 2;
SELECT employee_id, salary FROM employees WHERE employee_id = 2;
ROLLBACK;

-- Database health check
SELECT TABLE_NAME, TABLE_ROWS,
       ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024, 2) AS size_kb
FROM information_schema.tables
WHERE table_schema = 'employee_management';

-- Optional backup command (run in terminal, not SQL editor):
-- mysqldump -u root -p employee_management > employee_management_backup.sql

-- Optional restore command:
-- mysql -u root -p employee_management < employee_management_backup.sql
