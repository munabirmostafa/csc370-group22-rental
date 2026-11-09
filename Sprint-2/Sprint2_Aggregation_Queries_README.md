# Sprint 2: Equipment Rental Aggregation Queries and Results

## Overview

This work uses SQL aggregation to summarize information from our equipment rental database. The six queries count rentals and equipment, calculate daily rates, find repeat customers, and show how often equipment from each category was rented.

The queries are saved in `Sprint2_Aggregation_Queries.sql`. We ran them in MySQL Workbench and checked the results against our Sprint 1 sample data. Screenshots of each result are in the `results` folder.

## Running the Queries

The queries use the `csc370_sprint1` database from Sprint 1. It contains five tables: `Customer`, `Category`, `Equipment`, `Rental`, and `RentalItem`.

If the database is not set up, run `Sprint1.sql` to create the tables, then `sprint1insert.sql` to load the sample data into empty tables. If the data is already loaded, do not insert it again.

Open `Sprint2_Aggregation_Queries.sql` in MySQL Workbench and run the queries one at a time or together. The file starts with `USE csc370_sprint1;`. All six queries use `SELECT`, so they do not change the stored data.

## Queries and Results

### 1. Rentals per Customer

This query uses `LEFT JOIN`, `COUNT`, and `GROUP BY` to count each customer's rentals. `LEFT JOIN` keeps customers who have no rentals, and counting `r.rental_id` gives those customers a count of zero.

Sarah Smith has **2** rentals, Alex Chen and Danny Lee have **1** each, and Mina Rahman has **0**.

### 2. Equipment per Category

This query counts equipment items in each category using `COUNT` and `GROUP BY`. The `LEFT JOIN` would also include a category with no equipment.

Camera has **3** items. Microphone, lighting, and support each have **1**, for **6** equipment items in total.

### 3. Average Daily Rate by Category

This query uses `AVG` and `GROUP BY` to find the average listed daily equipment rate in each category. `ROUND` displays the averages to two decimal places.

Camera averages **66.67** per day, microphone **25.00**, lighting **40.00**, and support **15.00**. The camera average comes from rates of 85.00, 60.00, and 55.00. These are current listed rates, not historical rental charges.

### 4. Repeat Customers

This query groups rentals by customer and uses `HAVING COUNT(r.rental_id) > 1` to find customers with more than one rental.

Only **Sarah Smith (customer 18)** qualifies, with **2** rentals.

### 5. Equipment Summary by Status

This query groups equipment by status. `COUNT` counts items, `SUM` adds their listed daily rates, and `AVG` calculates the average rate.

| Status | Items | Combined daily rate | Average daily rate |
| --- | ---: | ---: | ---: |
| available | 2 | 55.00 | 27.50 |
| maintenance | 1 | 60.00 | 60.00 |
| rented | 3 | 165.00 | 55.00 |

The available items have rates of 40.00 and 15.00. These totals summarize listed prices, **not rental revenue**.

### 6. Rental Frequency by Category

This query joins `Category`, `Equipment`, and `RentalItem` and counts the number of rental-item records for each category.

Camera appears **3** times; microphone, lighting, and support each appear **1** time. The Sony FX3 appears in two rentals and the Sony A7 III in one. This measures equipment appearances in rentals, not distinct equipment owned or distinct rental transactions.

## Connection to Course Concepts

The queries demonstrate `COUNT`, `SUM`, `AVG`, `ROUND`, `GROUP BY`, and `HAVING`. `GROUP BY` forms groups for the calculations, while `HAVING` filters the grouped results. Joins connect related tables using the existing keys. `LEFT JOIN` also keeps customers or categories without matching records.

This work builds on our Sprint 1 database without changing its schema.

## Verification and Evidence

All six queries ran successfully in MySQL Workbench with MySQL Community Server 8.4.11. We checked the results against the Sprint 1 sample data: **4 customers, 4 categories, 6 equipment items, 4 rentals, and 6 rental-item records**.

| Query | Result checked | Screenshot |
| --- | --- | --- |
| 1. Rentals per customer | Sarah 2; Alex 1; Danny 1; Mina 0 | [View result](results/01_Customer_Rental_Count.png) |
| 2. Equipment per category | Camera 3; other categories 1 each | [View result](results/02_Equipment_Per_Category.png) |
| 3. Average rate per category | Camera 66.67; microphone 25.00; lighting 40.00; support 15.00 | [View result](results/03_Average_Daily_Rate_By_Category.png) |
| 4. Repeat customers | Sarah Smith has 2 rentals | [View result](results/04_Repeat_Customers.png) |
| 5. Equipment by status | Available 2; maintenance 1; rented 3, with totals and averages above | [View result](results/05_Equipment_Status_Summary.png) |
| 6. Rental frequency by category | Camera 3; other categories 1 each | [View result](results/06_Category_Rental_Frequency.png) |

The screenshots follow the same order as the queries in the SQL file. No extra sample data or schema changes were needed.
