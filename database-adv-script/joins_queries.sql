-- Task 0: Write Complex Queries with Joins

-- 1. INNER JOIN: Retrieve all bookings and the respective users who made those bookings
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_amount,
    u.user_id,
    u.username,
    u.email
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id
ORDER BY 
    b.start_date DESC, u.username ASC;

-- 2. LEFT JOIN: Retrieve all properties and their reviews, including properties with no reviews
SELECT 
    p.property_id,
    p.title,
    p.property_type,
    p.price_per_night,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at as review_date
FROM 
    Property p
LEFT JOIN 
    Review r ON p.property_id = r.property_id
ORDER BY 
    p.property_id ASC, r.rating DESC, r.created_at DESC;

-- 3. FULL OUTER JOIN: Retrieve all users and all bookings (MySQL doesn't support FULL OUTER JOIN, so we use UNION)
SELECT 
    u.user_id,
    u.username,
    u.email,
    u.created_at as user_joined,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id

UNION

SELECT 
    u.user_id,
    u.username,
    u.email,
    u.created_at as user_joined,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status
FROM 
    User u
RIGHT JOIN 
    Booking b ON u.user_id = b.user_id
WHERE 
    u.user_id IS NULL
ORDER BY 
    user_id ASC, start_date DESC;Inner Join
SELECT
  booking.id         AS booking_id,
  booking.property_id,
  booking.start_date,
  booking.end_date,
  booking.user_id,
  usr.name           AS user_name,
  usr.email          AS user_email
FROM bookings AS booking
INNER JOIN users AS usr
  ON booking.user_id = usr.id;

left join 
  SELECT
  prop.id            AS property_id,
  prop.title         AS property_title,
  rev.id             AS review_id,
  rev.user_id        AS reviewer_id,
  rev.rating,
  rev.comment
FROM properties AS prop
LEFT JOIN reviews AS rev
  ON prop.id = rev.property_id;

full outer join 
  SELECT
  usr.id             AS user_id,
  usr.name           AS user_name,
  usr.email          AS user_email,
  booking.id         AS booking_id,
  booking.property_id,
  booking.start_date,
  booking.end_date
FROM users AS usr
FULL OUTER JOIN bookings AS booking
  ON usr.id = booking.user_id;


INNER JOIN	Only bookings with an existing user and vice versa
LEFT JOIN	All properties, plus matching reviews (or NULL if none exist)
FULL OUTER JOIN	Everything from both tables, with NULL where no match exists
