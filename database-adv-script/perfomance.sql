-- Task 4: Optimize Complex Queries

-- Initial Query (Before Optimization)
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_amount,
    b.status,
    u.user_id,
    u.username,
    u.email,
    u.phone_number,
    p.property_id,
    p.title,
    p.property_type,
    p.price_per_night,
    p.bedrooms,
    p.bathrooms,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_status,
    pay.payment_date,
    h.username as host_username,
    h.email as host_email
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id
INNER JOIN 
    Property p ON b.property_id = p.property_id
INNER JOIN 
    User h ON p.host_id = h.user_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
WHERE 
    b.start_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND b.status = 'confirmed'
    AND p.property_type = 'apartment'
    AND p.price_per_night BETWEEN 50 AND 200
ORDER BY 
    b.start_date DESC, b.total_amount DESC;

-- Optimized Query (After Optimization)
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_amount,
    b.status,
    u.user_id,
    u.username,
    u.email,
    p.property_id,
    p.title,
    p.property_type,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_status
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id
INNER JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
WHERE 
    b.start_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND b.status = 'confirmed'
    AND p.property_type = 'apartment'
    AND p.price_per_night BETWEEN 50 AND 200
    AND b.total_amount > 0
    AND u.active = true
    AND p.is_available = true
ORDER BY 
    b.start_date DESC;

-- Performance Analysis Queries
-- Analyze initial query
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_amount,
    b.status,
    u.user_id,
    u.username,
    u.email,
    u.phone_number,
    p.property_id,
    p.title,
    p.property_type,
    p.price_per_night,
    p.bedrooms,
    p.bathrooms,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_status,
    pay.payment_date,
    h.username as host_username,
    h.email as host_email
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id
INNER JOIN 
    Property p ON b.property_id = p.property_id
INNER JOIN 
    User h ON p.host_id = h.user_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
WHERE 
    b.start_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND b.status = 'confirmed'
    AND p.property_type = 'apartment'
    AND p.price_per_night BETWEEN 50 AND 200;

-- Analyze optimized query
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_amount,
    b.status,
    u.user_id,
    u.username,
    u.email,
    p.property_id,
    p.title,
    p.property_type,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_status
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id
INNER JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
WHERE 
    b.start_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND b.status = 'confirmed'
    AND p.property_type = 'apartment'
    AND p.price_per_night BETWEEN 50 AND 200
    AND b.total_amount > 0
    AND u.active = true
    AND p.is_available = true;-- performance.sql

SELECT
  b.id            AS booking_id,
  b.start_date,
  b.end_date,
  u.id            AS user_id,
  u.name          AS user_name,
  u.email         AS user_email,
  p.id            AS property_id,
  p.title         AS property_title,
  p.price_per_night,
  pay.id          AS payment_id,
  pay.amount,
  pay.status,
  pay.paid_at
FROM bookings AS b
JOIN users AS u
  ON b.user_id = u.id
JOIN properties AS p
  ON b.property_id = p.id
LEFT JOIN payments AS pay
  ON b.id = pay.booking_id
WHERE b.start_date >= CURRENT_DATE - INTERVAL '30 days'
ORDER BY b.start_date DESC;

EXPLAIN ANALYZE
SELECT ... as above ... ;

CREATE INDEX idx_bookings_start_user_prop
  ON bookings (start_date, user_id, property_id);

CREATE INDEX idx_payments_booking
  ON payments (booking_id);

WITH recent_bookings AS (
  SELECT *
  FROM bookings
  WHERE start_date >= CURRENT_DATE - INTERVAL '30 days'
)
SELECT
  rb.id            AS booking_id,
  rb.start_date,
  rb.end_date,
  u.id             AS user_id,
  u.name           AS user_name,
  p.id             AS property_id,
  p.title          AS property_title,
  pay.amount,
  pay.status
FROM recent_bookings AS rb
JOIN users AS u ON rb.user_id = u.id
JOIN properties AS p ON rb.property_id = p.id
LEFT JOIN payments AS pay ON rb.id = pay.booking_id
ORDER BY rb.start_date DESC;

