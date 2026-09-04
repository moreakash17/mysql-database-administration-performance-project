# Employee Management Database

## Project Overview

A MySQL/SQL portfolio project designed to demonstrate relational database design, normalization, constraints, relationships, employee reporting, salary analysis, experience calculations, performance reporting, indexes, query-plan analysis, views, and transactions.

## Business Problem

Organizations need a reliable database to manage employee information, departments, job roles, salaries, managers, employment status, and performance. This project models those requirements using a normalized relational database.

## Database Structure

### Tables
- `departments` — department names and locations
- `roles` — job roles and salary ranges
- `employees` — employee details, department, role, manager, salary, experience and performance

### Relationships
- One department can have many employees.
- One role can be assigned to many employees.
- An employee can report to another employee through `manager_id`.

## Key SQL Concepts Demonstrated

- Database and table creation
- Primary keys
- Foreign keys
- Unique constraints
- `CHECK` constraints
- `ENUM` status values
- Normalized relational design
- `INNER JOIN` and `LEFT JOIN`
- Subqueries
- `GROUP BY` and aggregate functions
- `CASE` expressions
- Date and experience calculations
- Views
- Indexes
- `EXPLAIN`
- Transactions and `ROLLBACK`
- `information_schema`
- Backup and restore concepts

## Reports Included

1. Employee directory
2. Department-wise employee count
3. Department salary statistics
4. Role-wise employee statistics
5. Employees above average salary
6. Employee experience report
7. High-performance employees
8. Department performance report
9. Employee + department + role report
10. Manager/direct-report report
11. Salary-range validation
12. Database health check

## How to Run

1. Install MySQL 8.x and MySQL Workbench.
2. Open `employee_management.sql`.
3. Execute the complete script.
4. Verify the database with:

```sql
SHOW DATABASES;
USE employee_management;
SHOW TABLES;
```

5. Run each analytical query and review the output.
6. Run the `EXPLAIN` statement to inspect the query plan.
7. Test the transaction and confirm that `ROLLBACK` restores the salary.

## Resume Description

**Employee Management Database | MySQL / SQL**
- Developed a structured employee database containing employee, department, salary, and role information.
- Applied normalization and relational database design principles to reduce redundancy and improve data integrity.
- Wrote analytical SQL queries for department-wise employees, salary statistics, experience, and performance-related reporting.
- Implemented constraints and relationships to maintain reliable and consistent data.

## Interview Topics

Be prepared to explain:
- Why the database is normalized
- Why departments and roles are separate tables
- Primary key vs foreign key
- Why `manager_id` is a self-referencing foreign key
- Why constraints improve data integrity
- How the salary and performance reports work
- Why indexes were created
- What `EXPLAIN` tells you
- Why `LEFT JOIN` is used in department reporting
- How `ROLLBACK` works
