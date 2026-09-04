# SQL Troubleshooting & Query Optimization Practice - Project Report

## 1. Introduction

This project is a practical MySQL exercise designed to demonstrate SQL troubleshooting and basic query optimization skills. It simulates common issues encountered while working with relational databases, including syntax errors, missing database selection, invalid identifiers, data integrity problems, inefficient filtering and joins, and basic administration tasks.

## 2. Objectives

- Identify and correct common SQL errors.
- Validate databases, tables, columns and relationships.
- Detect data-quality and integrity issues.
- Practice filtering and JOIN techniques.
- Create and inspect indexes.
- Use EXPLAIN to analyze query execution plans.
- Practice transactions using COMMIT and ROLLBACK.
- Understand user permissions and read-only access.
- Practice backup and recovery concepts.
- Perform basic database health checks.

## 3. Database Design

The `sql_practice` database contains four related tables:

- `customers` - customer master data.
- `products` - product, pricing and inventory data.
- `orders` - customer order headers.
- `order_items` - products and quantities belonging to orders.

Primary keys identify records, while foreign keys maintain relationships between customers, orders and order items.

## 4. Troubleshooting Scenarios

### Syntax errors
The project includes malformed query examples as comments and corrected versions. The troubleshooting process focuses on reading the MySQL error, checking the reported location, validating SQL syntax and testing smaller query components.

### Missing database selection
`SELECT DATABASE()` and `USE sql_practice` demonstrate how to identify and fix the common "No database selected" situation.

### Invalid identifiers
`DESCRIBE` and `SHOW TABLES` are used to verify actual schema names before executing queries.

### Data integrity
Queries check duplicate emails, invalid numeric values, invalid quantities and orphan records. Database constraints provide an additional layer of protection.

## 5. Query Optimization

The project demonstrates practical first steps rather than claiming advanced performance engineering. Queries are structured to select required columns, filter data appropriately, use explicit JOIN conditions, and avoid unnecessary work.

Indexes are added to columns commonly used for joins and filters. `EXPLAIN` is used before and after indexing to inspect how MySQL plans to execute a query. `ANALYZE TABLE` is included to refresh optimizer statistics when appropriate.

## 6. Database Administration Scenarios

The project includes practice examples for:

- Checking the current database and MySQL version.
- Inspecting tables and table definitions.
- Checking database size and row estimates through `information_schema`.
- Creating a read-only user with `GRANT SELECT`.
- Reviewing privileges with `SHOW GRANTS`.
- Using transactions and safely testing `ROLLBACK` and `COMMIT`.
- Creating logical backups with `mysqldump`.
- Restoring a backup in a safe environment.

## 7. Expected Learning Outcomes

After completing this project, a learner should be able to:

1. Read and troubleshoot common MySQL errors.
2. Validate database schema before writing queries.
3. Identify basic data-integrity issues.
4. Write reliable SELECT and JOIN queries.
5. Understand why indexes can improve lookup performance.
6. Use `EXPLAIN` as a starting point for query analysis.
7. Explain the purpose of transactions and database permissions.
8. Describe a basic MySQL backup and recovery workflow.

## 8. Resume Value

This project supports a fresher portfolio for SQL, MySQL, Data Analyst, SQL Developer and DBA-oriented roles because it demonstrates practical troubleshooting rather than only theoretical SQL knowledge.

## 9. Resume Bullet Points

- Practiced identifying SQL syntax errors, missing database selection, invalid queries, and data integrity issues.
- Used indexes, filtering, joins, and query restructuring as basic techniques for improving query efficiency.
- Analyzed common database administration scenarios involving users, permissions, transactions, backups, and recovery.

## 10. Conclusion

The project provides a repeatable environment for practicing SQL troubleshooting and basic optimization. The exercises can be extended with larger datasets, slow-query logs, additional indexes, execution-plan comparisons, stored procedures, and monitoring tools as SQL skills improve.
