# RetailDB - MySQL Database Administration & Performance Project

A hands-on MySQL DBA portfolio project demonstrating database design, administration, security concepts, backup/recovery, indexing, query optimization, transactions, stored procedures, and monitoring.

## Objectives
- Design a normalized relational database
- Apply primary keys, foreign keys, unique constraints and integrity rules
- Practice database administration and health checks
- Create and analyze indexes using `EXPLAIN`
- Practice transactions with `COMMIT` and `ROLLBACK`
- Create stored procedures and views
- Practice backup and restore using `mysqldump`
- Understand read-only user privileges

## Tech Stack
- MySQL 8.x
- MySQL Workbench
- SQL
- Optional Windows/Linux terminal

## Database
The project uses a sample retail database named `retaildb` containing:
- departments
- employees
- customers
- products
- orders
- order_items

## How to Run
1. Install MySQL 8.x and MySQL Workbench.
2. Open `retaildb_project.sql` in MySQL Workbench.
3. Connect to your local MySQL server.
4. Execute the complete SQL script.
5. Verify the database with `SHOW DATABASES;` and `USE retaildb;`.
6. Run the included business queries and `EXPLAIN` statements.
7. Practice the backup, recovery and privilege commands documented in the SQL comments.

## DBA Activities Demonstrated
### Database Administration
- Database and table creation
- Primary/foreign keys
- Constraints and relationships
- Normalized relational design
- Database metadata checks through `information_schema`

### Performance Tuning
- Index creation on frequently joined/filtered columns
- Composite index on customer/date
- `EXPLAIN` query-plan inspection
- Basic query-performance troubleshooting concepts

### Transaction Management
- `START TRANSACTION`
- `COMMIT`
- `ROLLBACK`
- Safe stock update example with a quantity condition

### Security
The SQL includes commented examples for creating a read-only user, granting `SELECT`, checking grants, revoking privileges, and dropping the user. Change passwords before using these commands in a real environment.

### Backup & Recovery
Example `mysqldump` backup and MySQL restore commands are included as comments in the SQL script.

## Resume Description
**MySQL Database Administration & Performance Project | MySQL, SQL, MySQL Workbench**
- Designed and implemented a normalized retail database with primary keys, foreign keys and integrity constraints.
- Created indexes on frequently filtered and joined columns and used EXPLAIN to inspect query execution plans.
- Practiced transactions, COMMIT/ROLLBACK, stored procedures, user privileges, backup and recovery using mysqldump.
- Developed SQL queries and views for customer, employee, product, order and revenue analysis.

## Interview Questions Covered
1. Why are indexes used?
2. What is the difference between a primary key and foreign key?
3. Why is normalization important?
4. What does `EXPLAIN` show?
5. What is the difference between `COMMIT` and `ROLLBACK`?
6. How would you back up a MySQL database?
7. How would you restore a database backup?
8. How do you create a read-only database user?
9. What can cause a query to become slow?
10. What steps would you take to troubleshoot a production database issue?

## Portfolio Note
This is a learning and portfolio project. Do not claim production DBA experience unless you have actually worked in a production environment.
