Inner Join
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
  ON prop.id = rev.property_id
ORDER BY
  prop.title ASC,
  rev.id ASC;


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
