-- Task 2: Apply Aggregations and Window Functions

-- 1. Find the total number of bookings made by each user using COUNT and GROUP BY
SELECT 
    u.user_id,
    u.username,
    u.email,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_amount) AS total_spent,
    AVG(b.total_amount) AS average_booking_value
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.username, u.email
ORDER BY 
    total_bookings DESC, total_spent DESC;

-- 2. Use window functions to rank properties based on total number of bookings
SELECT 
    p.property_id,
    p.title,
    p.property_type,
    p.price_per_night,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_amount) AS total_revenue,
    -- ROW_NUMBER assigns unique sequential numbers
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank_row_number,
    -- RANK assigns same rank for ties, with gaps
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank,
    -- DENSE_RANK assigns same rank for ties, without gaps
    DENSE_RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_dense_rank,
    -- Additional: Rank by revenue as well
    RANK() OVER (ORDER BY SUM(b.total_amount) DESC) AS revenue_rank
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.title, p.property_type, p.price_per_night
ORDER BY 
    total_bookings DESC, total_revenue DESC;

-- 3. Additional: Window function with partitioning to rank properties within each property type
SELECT 
    p.property_id,
    p.title,
    p.property_type,
    p.price_per_night,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_amount) AS total_revenue,
    RANK() OVER (
        PARTITION BY p.property_type 
        ORDER BY COUNT(b.booking_id) DESC
    ) AS rank_within_property_type,
    RANK() OVER (
        PARTITION BY p.property_type 
        ORDER BY SUM(b.total_amount) DESC
    ) AS revenue_rank_within_property_type
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.title, p.property_type, p.price_per_night
ORDER BY 
    p.property_type, total_bookings DESC;

-- 4. Additional: Cumulative revenue using window functions
SELECT 
    p.property_id,
    p.title,
    p.property_type,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_amount) AS total_revenue,
    SUM(SUM(b.total_amount)) OVER (
        ORDER BY SUM(b.total_amount) DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue,
    ROUND(
        (SUM(b.total_amount) / SUM(SUM(b.total_amount)) OVER ()) * 100, 
        2
    ) AS revenue_percentage
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.title, p.property_type
ORDER BY 
    total_revenue DESC;SELECT 
  usr.id         AS user_id,
  usr.name       AS user_name,
  COUNT(b.id)    AS total_bookings
FROM users AS usr
LEFT JOIN bookings AS b
  ON b.user_id = usr.id
GROUP BY usr.id, usr.name
ORDER BY total_bookings DESC;

SELECT
  property_id,
  property_title,
  booking_count,
  RANK() OVER (
    ORDER BY booking_count DESC
  ) AS popularity_rank
FROM (
  SELECT
    prop.id           AS property_id,
    prop.title        AS property_title,
    COUNT(b.id)       AS booking_count
  FROM properties AS prop
  LEFT JOIN bookings AS b
    ON b.property_id = prop.id
  GROUP BY prop.id, prop.title
) AS sub
ORDER BY popularity_rank;
