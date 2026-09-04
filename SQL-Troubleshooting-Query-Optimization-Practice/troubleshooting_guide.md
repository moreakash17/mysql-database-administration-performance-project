# SQL Troubleshooting Guide

## 1. ERROR 1046: No database selected

**Cause:** MySQL does not know which database should receive the query.

**Check:**
```sql
SELECT DATABASE();
```

**Fix:**
```sql
USE sql_practice;
```

## 2. Syntax Error

**Typical causes:** missing comma, misspelled keyword, incorrect parentheses, or invalid SQL clause order.

**Troubleshooting process:**
1. Read the error message and line number.
2. Check the SQL keyword near the reported position.
3. Verify commas and parentheses.
4. Check table and column names.
5. Execute a smaller version of the query.

## 3. Unknown Column

**Cause:** The column does not exist, is misspelled, or is referenced with the wrong alias.

**Useful command:**
```sql
DESCRIBE customers;
```

## 4. Unknown Table

**Cause:** Wrong table name or wrong database selected.

**Useful commands:**
```sql
SELECT DATABASE();
SHOW TABLES;
```

## 5. Data Integrity Problems

Check for:
- Duplicate values
- Unexpected NULL values
- Negative prices or quantities
- Missing parent records
- Invalid foreign-key references

Example:
```sql
SELECT email, COUNT(*)
FROM customers
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;
```

## 6. Slow Query Troubleshooting

A basic workflow is:

1. Reproduce the slow query.
2. Select only the required columns.
3. Check filtering conditions.
4. Review JOIN conditions.
5. Run `EXPLAIN`.
6. Check whether useful indexes exist.
7. Add or adjust indexes only when justified.
8. Re-run `EXPLAIN` and compare the plan.
9. Test with realistic data volume.
10. Monitor the effect of the change.

## 7. Transaction Problems

Use transactions when multiple related changes must succeed or fail together.

```sql
START TRANSACTION;
-- changes
COMMIT;
```

If the changes should be cancelled:

```sql
ROLLBACK;
```

## 8. Permission Problems

When a user receives an access-denied error, verify:

```sql
SELECT CURRENT_USER();
SHOW GRANTS;
```

Administrators can review the user's granted privileges and provide only the permissions required for the task.

## 9. Backup and Recovery

A common MySQL logical backup is created with `mysqldump`:

```text
mysqldump -u root -p sql_practice > sql_practice_backup.sql
```

A backup should be tested periodically by restoring it in a safe environment.

## 10. DBA Troubleshooting Checklist

- Confirm the database/server is available.
- Confirm the correct database is selected.
- Read the exact error message.
- Validate table and column names.
- Check constraints and relationships.
- Check user privileges.
- Check transaction state.
- Use `EXPLAIN` for query-performance issues.
- Check indexes and table statistics.
- Review backup/recovery status for data-protection issues.
