# SQL Troubleshooting & Query Optimization Practice

A hands-on SQL/MySQL practice project focused on troubleshooting common database errors, fixing invalid queries, improving query efficiency, and practicing basic database administration scenarios.

## Project Objective

This project demonstrates practical SQL troubleshooting skills that are useful for a SQL Developer, Data Analyst, Database Administrator, or technical support role.

## Skills Demonstrated

- SQL syntax troubleshooting
- Database and table validation
- Missing database selection troubleshooting
- Invalid query identification and correction
- Data integrity checks
- NULL and duplicate-data handling
- Filtering with WHERE
- JOIN optimization basics
- Index creation and inspection
- EXPLAIN query-plan analysis
- Query restructuring
- Transactions with COMMIT and ROLLBACK
- User and permission concepts
- Backup and recovery commands
- Basic database health checks

## Tools

- MySQL 8.x
- MySQL Workbench
- SQL

## Project Structure

```text
SQL-Troubleshooting-Query-Optimization-Practice/
├── README.md
├── sql_troubleshooting_optimization.sql
├── troubleshooting_guide.md
└── project_report.md
```

## How to Run

1. Open MySQL Workbench and connect to your local MySQL server.
2. Open `sql_troubleshooting_optimization.sql`.
3. Execute the script from top to bottom.
4. The script creates a practice database named `sql_practice`.
5. Review each troubleshooting example and its corrected query.
6. Run the `EXPLAIN` examples before and after indexing where appropriate.
7. Practice the transaction, user privilege, backup and recovery sections carefully.

## Main Scenarios

### 1. Syntax Errors
Examples include missing commas, incorrect keywords, invalid column names, and malformed SELECT statements.

### 2. Missing Database Selection
Demonstrates the common MySQL `ERROR 1046: No database selected` situation and the correct use of `USE database_name`.

### 3. Data Integrity Problems
Checks duplicate emails, NULL values, invalid foreign-key references, negative quantities, and inconsistent prices.

### 4. Query Optimization
Uses appropriate filtering, joins, indexes, and `EXPLAIN` to understand query execution.

### 5. Database Administration
Includes examples and commented commands for users, permissions, transactions, backup, restore, and database health checks.

## Resume Description

**SQL Troubleshooting & Query Optimization Practice | SQL / MySQL**

- Practiced identifying SQL syntax errors, missing database selection, invalid queries, and data integrity issues.
- Used indexes, filtering, joins, and query restructuring as basic techniques for improving query efficiency.
- Analyzed common database administration scenarios involving users, permissions, transactions, backups, and recovery.

## Important Note

This is a portfolio and learning project. Backup, user-management, and privilege commands are provided for practice; do not use example passwords or destructive commands in a production database.
