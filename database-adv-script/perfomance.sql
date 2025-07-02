-- performance.sql

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

