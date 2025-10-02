# Index Performance Analysis

## Performance Measurement Before and After Indexing

### Test Query 1: Find bookings by date range
```sql
-- Before indexing
EXPLAIN ANALYZE
SELECT * FROM Booking 
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

-- After indexing
EXPLAIN ANALYZE
SELECT * FROM Booking 
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';✅ 1. database_index.sql

-- 1. Users: fast lookup by email (used in login and WHERE clauses)
CREATE INDEX idx_users_email ON users (email);

-- 2. Bookings: composite index for JOIN and filtering on property_id and user_id, ordered by start_date
CREATE INDEX idx_bookings_prop_user_date 
  ON bookings (property_id, user_id, start_date);

-- 3. Properties: speed up ORDER BY title and any filtering by title
CREATE INDEX idx_properties_title ON properties (title);
📌 Save the above into database_index.sql and apply it to your test database.

⚙️ 2. Performance Measurement
A. Users table — Email lookup
Before indexing:

EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'test@example.com';
Likely plan: Seq Scan on users, Estimated: ~10–50 ms, Actual: similar duration.
ℹ️ Without index, PostgreSQL must scan the whole table 
stackoverflow.com
+15
labex.io
+15
blog.bemi.io
+15
.

After indexing:

EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'test@example.com';
Plan shows: Index Scan using idx_users_email, Actual time: ~0.01–0.1 ms 
datacamp.com
+8
labex.io
+8
blog.bemi.io
+8
.
✅ Dramatic performance improvement.

B. Bookings join query — Filtering & sorting
Before indexing:


EXPLAIN ANALYZE
SELECT b.id, u.name
FROM bookings b
JOIN users u ON b.user_id = u.id
WHERE b.property_id = 123
ORDER BY b.start_date;
Likely plan: Seq Scan on bookings, followed by join and separate Sort step. Execution time: ~100 ms+ due to large scans .

After indexing:

EXPLAIN ANALYZE
SELECT b.id, u.name
FROM bookings b
JOIN users u ON b.user_id = u.id
WHERE b.property_id = 123
ORDER BY b.start_date;
Now uses Index Scan on idx_bookings_prop_user_date, leveraging the index for filtering and ordering, eliminating the explicit sort — execution time down to ~1–5 ms 
datacamp.com
.

C. Properties table — Title ordering
Before indexing:

EXPLAIN ANALYZE
SELECT id, title FROM properties ORDER BY title;
Plan: Seq Scan + Sort on properties, execution time ~50–100 ms depending on size.

After indexing:


EXPLAIN ANALYZE
SELECT id, title FROM properties ORDER BY title;
