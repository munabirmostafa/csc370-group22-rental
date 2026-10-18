USE csc370_sprint1;

SELECT e.equipment_id, e.name AS equipment_name,
       c.category_name, e.daily_rate
FROM Equipment AS e
JOIN Category AS c ON c.category_id = e.category_id
WHERE e.status = 'available'
  AND NOT EXISTS (
      SELECT 1
      FROM RentalItem AS ri
      JOIN Rental AS r ON r.rental_id = ri.rental_id
      WHERE ri.equipment_id = e.equipment_id
        AND r.actual_return_date IS NULL
  )
ORDER BY e.equipment_id;

SELECT c.customer_id, c.name AS customer_name,
       r.rental_id,
       CAST(r.rental_date AS CHAR) AS rental_date,
       CAST(r.expected_return_date AS CHAR) AS expected_return_date,
       CAST(r.actual_return_date AS CHAR) AS actual_return_date
FROM Customer AS c
LEFT JOIN Rental AS r ON r.customer_id = c.customer_id
ORDER BY c.customer_id, r.rental_date, r.rental_id;

SELECT r.rental_id, c.name AS customer_name,
       e.equipment_id, e.name AS equipment_name, ri.rental_rate
FROM Rental AS r
JOIN Customer AS c ON c.customer_id = r.customer_id
JOIN RentalItem AS ri ON ri.rental_id = r.rental_id
JOIN Equipment AS e ON e.equipment_id = ri.equipment_id
WHERE r.rental_id = 20
ORDER BY e.equipment_id;

SELECT e.equipment_id, e.name AS equipment_name,
       r.rental_id, c.name AS customer_name,
       CAST(r.rental_date AS CHAR) AS rental_date,
       CAST(r.actual_return_date AS CHAR) AS actual_return_date,
       ri.rental_rate AS charged_daily_rate,
       e.daily_rate AS current_daily_rate
FROM Equipment AS e
JOIN RentalItem AS ri ON ri.equipment_id = e.equipment_id
JOIN Rental AS r ON r.rental_id = ri.rental_id
JOIN Customer AS c ON c.customer_id = r.customer_id
WHERE e.equipment_id = 104
ORDER BY r.rental_date, r.rental_id;

SELECT r.rental_id, c.name AS customer_name,
       COUNT(ri.equipment_id) AS item_count,
       COALESCE(SUM(ri.rental_rate), 0) AS total_daily_rate
FROM Rental AS r
JOIN Customer AS c ON c.customer_id = r.customer_id
LEFT JOIN RentalItem AS ri ON ri.rental_id = r.rental_id
GROUP BY r.rental_id, c.name
ORDER BY r.rental_id;

SELECT c.customer_id, c.name AS customer_name,
       COUNT(r.rental_id) AS rental_count
FROM Customer AS c
JOIN Rental AS r ON r.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(r.rental_id) >= 2
ORDER BY c.customer_id;

SELECT r.rental_id, c.name AS customer_name,
       CAST(r.rental_date AS CHAR) AS rental_date,
       CAST(r.expected_return_date AS CHAR) AS expected_return_date
FROM Rental AS r
JOIN Customer AS c ON c.customer_id = r.customer_id
WHERE r.actual_return_date IS NULL
  AND r.expected_return_date < '2026-10-18'
ORDER BY r.expected_return_date, r.rental_id;
