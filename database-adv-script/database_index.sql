-- 1. Users: fast lookup by email (used in login and WHERE clauses)
CREATE INDEX idx_users_email ON users (email);

-- 2. Bookings: composite index for JOIN and filtering on property_id and user_id, ordered by start_date
CREATE INDEX idx_bookings_prop_user_date 
  ON bookings (property_id, user_id, start_date);

-- 3. Properties: speed up ORDER BY title and any filtering by title
CREATE INDEX idx_properties_title ON properties (title);
