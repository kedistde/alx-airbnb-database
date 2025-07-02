SELECT 
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
