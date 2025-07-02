1. Identify High-Usage Columns
users table: email (used in WHERE, login), id (FK).

bookings table: user_id, property_id (JOIN keys), start_date (filtering).

properties table: title, id (BOOKING FK), possibly price.

These columns are prime candidates because they're frequently part of WHERE, JOIN, or ORDER BY clauses 
dev.to
+15
codezup.com
+15
datacamp.com
+15
.

📁 2. database_index.sql
sql
Copy
Edit
-- Users: fast lookup by email
CREATE INDEX idx_users_email ON users (email);

-- Bookings: speed up filtering/joining on user and property, and sorting by start date
CREATE INDEX idx_bookings_user_property_date 
  ON bookings (user_id, property_id, start_date);

-- Properties: accelerate joins and sorts by title
CREATE INDEX idx_properties_title ON properties (title);
The composite index on bookings(user_id, property_id, start_date) supports:

WHERE user_id = …

JOIN ... ON property_id

ORDER BY start_date
❗ Order of columns matches WHERE → JOIN → ORDER BY for maximum efficiency .

🧪 3. Performance Measurement with EXPLAIN ANALYZE
Example A: Query before & after index on users.email
sql
Copy
Edit
EXPLAIN ANALYZE
SELECT * 
FROM users 
WHERE email = 'test@example.com';
Before index: likely sequential scan, ~10–50 ms.

After index: index scan, target ~0.01–0.1 ms — massive improvement 
