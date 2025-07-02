SELECT
  p.id           AS property_id,
  p.title        AS property_title,
  sub.avg_rating
FROM properties AS p
JOIN (
  SELECT
    property_id,
    AVG(rating) AS avg_rating
  FROM reviews
  GROUP BY property_id
) AS sub
  ON p.id = sub.property_id
WHERE sub.avg_rating > 4.0
ORDER BY sub.avg_rating DESC;

SELECT
  usr.id          AS user_id,
  usr.name        AS user_name,
  usr.email,
  (
    SELECT COUNT(*)
    FROM bookings AS b
    WHERE b.user_id = usr.id
  ) AS booking_count
FROM users AS usr
WHERE (
    SELECT COUNT(*)
    FROM bookings AS b
    WHERE b.user_id = usr.id
  ) > 3
ORDER BY booking_count DESC;
