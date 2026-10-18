# Sprint 1: Equipment Rental Queries and Results

## Overview

The goal of the query work for Sprint 1 was to retrieve useful information from the equipment rental database and demonstrate the SQL concepts used. The seven queries cover available equipment, customer rentals, rental history, daily rental prices, repeat customers, and overdue rentals.

The queries are saved in `Rental_Queries.sql`. We ran each query in MySQL Workbench and checked the results against the Sprint 1 sample data. This document explains those results and links each query to its saved evidence. The video demonstration will show the queries running and explain their output.

## Running the Queries

The queries use the `csc370_sprint1` database. They require the tables from `Sprint1.sql` and the sample data from `sprint1insert.sql` to be loaded first. For a fresh setup, create and select the database, run the schema file, and load the insert file into the empty tables.

Once this setup is complete, open `Rental_Queries.sql` in MySQL Workbench. Each query can be run separately or the whole file can be run together. The file begins with `USE csc370_sprint1;` to select the database. The SELECT statements retrieve information without changing the stored data.

## Queries and Results

### 1. Finding Available Equipment

This query finds equipment marked as available and checks that it is not part of an unreturned rental. It joins `Equipment` with `Category` to show the category name. The `NOT EXISTS` subquery checks for open rentals of each item.

The result contains two items: the Aputure light, equipment 106, at 40.00 per day, and the Manfrotto tripod, equipment 107, at 15.00 per day. Equipment marked as rented or under maintenance is excluded.

### 2. Viewing Customers and Their Rentals

This query uses a `LEFT JOIN` between `Customer` and `Rental`. It includes every customer, even when that customer has no rentals.

Sarah Smith appears twice for rentals 21 and 20. Alex Chen appears for rental 23. Danny Lee appears for rental 22. Mina Rahman is also included, but her rental fields are NULL because she has no recorded rentals. The query returns five rows for four customers.

For an existing rental, a NULL `actual_return_date` means that a return has not been recorded. This is different from Mina's row, where there is no matching rental at all.

### 3. Viewing the Items in a Rental

This query shows the equipment included in rental 20. It joins `Rental`, `Customer`, `RentalItem`, and `Equipment`, then uses `WHERE` to select that rental.

The result shows that Sarah Smith rented a Sony FX3 at 85.00 per day and a Rode NTG5 at 25.00 per day. Both items belong to the same rental. This demonstrates how `RentalItem` connects a rental to its equipment items.

### 4. Checking Equipment Rental History

This query finds the rental history of equipment 104, the Sony FX3. It shows the customer, rental dates, return dates, and daily prices. The results are ordered by rental date.

The camera appears in Sarah Smith's rentals 21 and 20. Rental 21 started on September 20 and was returned on September 22. Rental 20 started on October 4 and has no recorded return date.

The earlier rental has a charged daily rate of 80.00. The current listed daily rate is 85.00. Keeping the charged rate in `RentalItem` preserves the price agreed for an earlier rental when the equipment's listed price changes.

### 5. Counting Items and Calculating Daily Rental Prices

This query groups the equipment items by rental. `COUNT` gives the number of items and `SUM` adds their charged daily rates.

| Rental ID | Customer | Number of items | Combined daily rate |
| --- | --- | --- | --- |
| 20 | Sarah Smith | 2 | 110.00 |
| 21 | Sarah Smith | 2 | 115.00 |
| 22 | Danny Lee | 1 | 15.00 |
| 23 | Alex Chen | 1 | 55.00 |

For example, rental 20 contains two items with rates of 85.00 and 25.00, giving a combined daily rate of 110.00. These amounts are daily prices. A full rental bill would also need to account for the rental duration.

The `LEFT JOIN` allows a rental with no items to remain in the result. In that case, `COUNT` would give zero and `COALESCE` would make the daily total zero. The current sample data has at least one item in every rental.

### 6. Finding Repeat Customers

This query counts the rentals made by each customer. It uses `GROUP BY` to group their rentals and `HAVING` to keep customers with at least two rentals.

The result contains Sarah Smith, customer 18, with two rentals. The other customers do not meet this condition in the sample data.

### 7. Finding Overdue Rentals

This query checks for rentals that have not been returned and were due before October 18, 2026. It uses `IS NULL` to check for a missing actual return date and compares the expected return date with the fixed demonstration date.

The result contains Sarah Smith's rental 20. It started on October 4 and was due on October 7. Alex Chen's rental 23 is also unreturned, but it is due on October 20, so it is excluded. Using a fixed date keeps this demonstration consistent when the file is run later.

## Connection to Course Concepts

The queries use selection through `WHERE` conditions and projection by choosing the columns in `SELECT`. Joins combine related records using the primary and foreign keys in our schema. Joining through `RentalItem` shows how the many-to-many relationship between rentals and equipment is represented in the relational model.

The queries also use outer joins, subqueries, aggregate functions, and grouping. The customer query shows why an outer join is useful when some records have no match. The repeat-customer query shows how `HAVING` filters groups after counting. These examples connect the database design to useful information that can be retrieved from the stored records.

## Verification and Evidence

All seven queries were executed successfully using MySQL Community Server 8.4.11 through MySQL Workbench. We checked the returned rows and calculations against the loaded sample data. The table below connects each query to a specific result that can be checked again by running the SQL file.

| Query | Result checked | Screenshot |
| --- | --- | --- |
| 1. Available equipment | Exactly two items: equipment 106 and 107. | [View result](results/01_Available_Equipment.png) |
| 2. Customers and rentals | Five rows for four customers. Mina remains in the result with NULL rental fields. | [View result](results/02_Customer_Rentals.png) |
| 3. Items in a rental | Rental 20 contains equipment 104 and 105. | [View result](results/03_Rental_Items.png) |
| 4. Equipment rental history | Equipment 104 appears in rentals 21 and 20. The earlier charged daily rate is 80.00 and the current listed rate is 85.00. | [View result](results/04_Equipment_History.png) |
| 5. Item counts and daily rates | Rentals 20, 21, 22, and 23 have combined daily rates of 110.00, 115.00, 15.00, and 55.00 respectively. Their item counts are 2, 2, 1, and 1. | [View result](results/05_Rental_Daily_Totals.png) |
| 6. Repeat customers | Only Sarah Smith, customer 18, meets the condition, with two rentals. | [View result](results/06_Repeat_Customers.png) |
| 7. Overdue rentals | Only rental 20 is unreturned and overdue as of October 18, 2026. | [View result](results/07_Overdue_Rentals.png) |

The screenshots in `results` follow the same order as the queries in `Rental_Queries.sql`. These checks confirm the seven query examples using the current sample data.

## Technical Issue and Resolution

The Workbench result grid initially displayed dates one day earlier than the inserted values. For example, a rental date of `2026-10-04` appeared as `2026-10-03`. Displaying the date with `CAST(... AS CHAR)` returned `2026-10-04`, matching the insert file.

We applied this conversion to the date columns shown in the customer, equipment-history, and overdue-query results. The stored columns remain DATE columns. Filtering and sorting still use those stored dates. The saved screenshots show the corrected output.

## Video Demonstration

In the query segment of the video, we will run the SQL in MySQL Workbench using the same sample data. We will explain the question each query answers, the SQL concepts used, and the result that confirms it works. The SQL file and screenshots provide the supporting evidence for this demonstration.
