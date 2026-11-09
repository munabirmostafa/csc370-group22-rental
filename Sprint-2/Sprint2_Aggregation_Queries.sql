USE csc370_sprint1;

-- Query 1: Count how many rentals each customer has made

SELECT
    c.customer_id,
    c.name AS customer_name,
    COUNT(r.rental_id) AS rental_count
FROM Customer AS c
LEFT JOIN Rental AS r
    ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.name
ORDER BY c.customer_id;

-- Query 2: Count how many equipment items belong to each category

SELECT
    c.category_id,
    c.category_name,
    COUNT(e.equipment_id) AS equipment_count
FROM Category AS c
LEFT JOIN Equipment AS e
    ON c.category_id = e.category_id
GROUP BY c.category_id, c.category_name
ORDER BY c.category_id;

-- Query 3: Calculate the average daily rental rate for each equipment category

SELECT
    c.category_id,
    c.category_name,
    ROUND(AVG(e.daily_rate), 2) AS average_daily_rate
FROM Category AS c
LEFT JOIN Equipment AS e
    ON c.category_id = e.category_id
GROUP BY c.category_id, c.category_name
ORDER BY c.category_id;

-- Query 4: Find customers who have made more than one rental

SELECT
    c.customer_id,
    c.name AS customer_name,
    COUNT(r.rental_id) AS rental_count
FROM Customer AS c
JOIN Rental AS r
    ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(r.rental_id) > 1
ORDER BY c.customer_id;

-- Query 5: Count equipment and calculate total and average
-- daily rental rates for each equipment status

SELECT
    status,
    COUNT(*) AS equipment_count,
    SUM(daily_rate) AS total_daily_rate,
    ROUND(AVG(daily_rate), 2) AS average_daily_rate
FROM Equipment
GROUP BY status
ORDER BY status;

-- Query 6: Count how many times equipment from each category

SELECT
    c.category_id,
    c.category_name,
    COUNT(ri.rental_id) AS times_rented
FROM Category AS c
LEFT JOIN Equipment AS e
    ON c.category_id = e.category_id
LEFT JOIN RentalItem AS ri
    ON e.equipment_id = ri.equipment_id
GROUP BY c.category_id, c.category_name
ORDER BY c.category_id;