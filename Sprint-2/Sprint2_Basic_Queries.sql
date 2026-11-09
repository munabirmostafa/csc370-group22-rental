USE csc370_sprint1;
SHOW TABLES;
-- Query 1: Show the different equipment categories currently in the database
SELECT DISTINCT category_name
FROM Category
ORDER BY category_name;
-- Query 2: Find available equipment that costs less than $50 per day
SELECT equipment_id, name, daily_rate
FROM Equipment
WHERE status = 'available'
  AND daily_rate < 50
ORDER BY daily_rate;
-- Query 3: Show all equipment in the Camera category
SELECT
    e.equipment_id,
    e.name AS equipment_name,
    c.category_name,
    e.daily_rate,
    e.status
FROM Equipment AS e
JOIN Category AS c
    ON e.category_id = c.category_id
WHERE c.category_name = 'camera'
ORDER BY e.daily_rate DESC;
-- Query 4: Show rentals that started during October 2026
SELECT
    rental_id,
    customer_id,
    CAST(rental_date AS CHAR) AS rental_date,
    CAST(expected_return_date AS CHAR) AS expected_return_date,
    CAST(actual_return_date AS CHAR) AS actual_return_date
FROM Rental
WHERE rental_date >= '2026-10-01'
  AND rental_date < '2026-11-01'
ORDER BY rental_date;