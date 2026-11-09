USE csc370_sprint1;


-- Demonstrates a query with scalar subquery
-- Query: Find the cheapest equipment to rent per day
SELECT 
	equipment_id, 
	category_id, 
	name, 
    serial_number, 
    daily_rate, 
    status
FROM Equipment
WHERE daily_rate = 
(
SELECT MIN(daily_rate)
FROM Equipment
);


-- Demonstrates a correlated subquery
-- Query: Finds equipment that is cheaper than average in its category
SELECT 
	`outer`.equipment_id, 
    `outer`.category_id, 
    `outer`.name, 
    `outer`.serial_number, 
    `outer`.daily_rate, 
    `outer`.status
FROM Equipment as `outer`
WHERE `outer`.daily_rate < 
(
    SELECT AVG(`inner`.daily_rate)
    FROM Equipment as `inner`
    WHERE `inner`.category_id = `outer`.category_id
);


-- Demonstrates use of exestential quantifiers in a subquery using ANY
-- Query: Finds the rental items which are more expensive then the cheapest rental items
SELECT 
	rental_id, 
    equipment_id, 
    rental_rate
FROM RentalItem
WHERE rental_rate > ANY
(
SELECT rental_rate
FROM RentalItem
);


-- Demonstrates use of exestential quantifiers in a subquery using EXISTS
-- Query: Finds customers who have place a rental
SELECT 
	c.customer_id, 
    c.name, 
    c.email, 
    c.phone
FROM Customer as c
WHERE EXISTS (
    SELECT *
    FROM Rental as r
    WHERE c.customer_id = r.customer_id
);


-- Demonstrates use of universal quantifiers in a subquery using ALL
-- Query: Finds customer that have placed the most rentals
SELECT 
	c.customer_id, 
    c.name, 
    c.phone, 
    c.email,
    count(*) as `Number of rentals`
FROM Customer as c
JOIN Rental as r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.name, c.phone, c.email
HAVING COUNT(*) >= ALL 
(
SELECT COUNT(*)
FROM Rental
GROUP BY customer_id
);