-- Task 3: Implement Indexes for Optimization

-- Identify high-usage columns and create indexes

-- 1. Indexes for User table
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_created_at ON User(created_at);
CREATE INDEX idx_user_username ON User(username);

-- 2. Indexes for Booking table
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_start_date ON Booking(start_date);
CREATE INDEX idx_booking_end_date ON Booking(end_date);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);

-- 3. Indexes for Property table
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_property_property_type ON Property(property_type);
CREATE INDEX idx_property_price ON Property(price_per_night);
CREATE INDEX idx_property_location ON Property(city, country);
CREATE INDEX idx_property_created_at ON Property(created_at);

-- 4. Indexes for Review table
CREATE INDEX idx_review_property_id ON Review(property_id);
CREATE INDEX idx_review_user_id ON Review(user_id);
CREATE INDEX idx_review_rating ON Review(rating);
CREATE INDEX idx_review_created_at ON Review(created_at);

-- 5. Composite indexes for common query patterns
CREATE INDEX idx_booking_user_date ON Booking(user_id, start_date);
CREATE INDEX idx_property_type_price ON Property(property_type, price_per_night);
CREATE INDEX idx_review_property_rating ON Review(property_id, rating);-- 1. Users: fast lookup by email (used in login and WHERE clauses)
CREATE INDEX idx_users_email ON users (email);

-- 2. Bookings: composite index for JOIN and filtering on property_id and user_id, ordered by start_date
CREATE INDEX idx_bookings_prop_user_date 
  ON bookings (property_id, user_id, start_date);

-- 3. Properties: speed up ORDER BY title and any filtering by title
CREATE INDEX idx_properties_title ON properties (title);
