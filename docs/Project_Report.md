# RetailDB — MySQL Database Administration & Performance Project

## 1. Project Overview
RetailDB is a hands-on MySQL portfolio project designed to demonstrate core Database Administrator skills. It covers relational database design, constraints, indexing, query analysis, transactions, stored procedures, backup and recovery concepts, security privileges, and database health checks.

## 2. Objectives
- Build a normalized retail database.
- Define primary keys, foreign keys and integrity constraints.
- Insert and manage realistic sample data.
- Create views for reporting.
- Create indexes for frequently filtered and joined columns.
- Use EXPLAIN to inspect query execution plans.
- Demonstrate COMMIT and ROLLBACK.
- Create and execute a stored procedure.
- Practice MySQL backup and restore commands.
- Understand read-only user privileges.
- Query information_schema for basic database health/metadata checks.

## 3. Database Modules
The database contains six related tables:

1. **departments** — department master data.
2. **employees** — employee records linked to departments.
3. **customers** — customer information.
4. **products** — product catalog, prices and inventory.
5. **orders** — customer order headers and status.
6. **order_items** — products and quantities belonging to each order.

## 4. Administration Activities
The SQL script demonstrates database creation, table creation, relationships, constraints, data loading, views, metadata checks, transaction management, stored procedures, and security/backup examples.

## 5. Performance Activities
Indexes are created on department IDs, hire dates, order customer/date, order status, order IDs, product IDs, and product categories. The project also includes an EXPLAIN example to inspect how MySQL accesses data for a customer-order query.

In a real production environment, indexes should be selected based on actual workload, query patterns, cardinality, write overhead, and execution plans rather than added blindly.

## 6. Transaction Demonstration
The project includes two stock-update examples. The first uses ROLLBACK to demonstrate undoing a transaction. The second uses COMMIT to persist a safe stock decrement.

## 7. Backup & Recovery
The SQL comments include example commands using `mysqldump` for logical backup and the MySQL client for restoration. In production, backup strategy should additionally consider retention, encryption, off-site storage, point-in-time recovery, testing, monitoring, and recovery objectives.

## 8. Security Demonstration
The project includes commented examples for creating a read-only account, granting SELECT access, checking grants, revoking access, and removing the account. The sample password must be replaced before any real use.

## 9. Expected Learning Outcomes
After completing this project, a learner should be able to explain relational database design, normalization, constraints, indexing, EXPLAIN, transactions, backup/recovery, basic database security, and common DBA troubleshooting steps.

## 10. Resume Value
**MySQL Database Administration & Performance Project | MySQL, SQL, MySQL Workbench**

- Designed and implemented a normalized retail database with primary keys, foreign keys and integrity constraints.
- Created indexes on frequently filtered and joined columns and used EXPLAIN to inspect query execution plans.
- Practiced transactions, COMMIT/ROLLBACK, stored procedures, user privileges, backup and recovery using mysqldump.
- Developed SQL queries and views for customer, employee, product, order and revenue analysis.

## 11. Interview Questions
- Why are indexes used?
- What is the difference between a primary key and foreign key?
- Why is normalization important?
- What does EXPLAIN show?
- What is the difference between COMMIT and ROLLBACK?
- How do you back up a MySQL database?
- How do you restore a database backup?
- How do you create a read-only user?
- What can cause a query to become slow?
- How would you troubleshoot a database issue?

## 12. Important Note
This is a learning and portfolio project. It should not be presented as production DBA experience unless the candidate has actually performed these activities in a production environment.
