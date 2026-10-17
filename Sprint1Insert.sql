-- Contraints to check:
-- Customer: (customer_id > 0)
-- Equipment: (daily_rate >= 0)
-- Equipment: (status IN ('available', 'rented', 'maintenance'))
-- Rental: (expected_return_date >= rental_date),
-- Rental: (actual_return_date = NULL OR actual_return_date >= rental_date)
-- Rentalitem: (rental_rate >= 0)


-- VALID INSERTS

-- INSERT CATEGORY
INSERT INTO category (category_id, category_name)
VALUES (2, 'camera');

-- INSERT EQUIPMENT
INSERT INTO equipment (equipment_id, name, serial_number, daily_rate, status, category_id)
VALUES (104, 'Sony FX3', 'XYZ3000', 85.00, 'available', 2);

-- INSERT CUSTOMER
INSERT INTO customer (customer_id, name, email, phone)
VALUES (18, 'Sarah Smith', 'sarah@example.com', '250-555-1234');

-- INSERT RENTAL
INSERT INTO Rental (rental_id, customer_id, rental_date, expected_return_date, actual_return_date)
VALUES ('20', '18', '2026-10-04', '2026-10-07', NULL);

-- INSERT RENTAL ITEM
INSERT INTO Rentalitem (rental_id, equipment_id, rental_rate)
VALUES ('20', '104', 85.00);


-- NOT VALID INSERTS

-- Equipment: (daily_rate >= 0)
-- INSERT INTO equipment (equipment_id, name, serial_number, daily_rate, status, category_id)
-- VALUES (105, 'Sony FX3', 'XYZ4000', -85.00, 'available', 2);

-- Equipment: (status IN ('available', 'rented', 'maintenance'))
-- INSERT INTO equipment (equipment_id, name, serial_number, daily_rate, status, category_id)
-- VALUES (106, 'Sony FX3', 'XYZ5000', 85.00, 'abailable', 2);

-- Rental: (expected_return_date >= rental_date)
-- INSERT INTO Rental (rental_id, customer_id, rental_date, expected_return_date, actual_return_date)
-- VALUES ('21', '18', '2026-10-04', '1000-10-07', NULL);

-- Rental: (actual_return_date = NULL OR actual_return_date >= rental_date)
-- INSERT INTO Rental (rental_id, customer_id, rental_date, expected_return_date, actual_return_date)
-- VALUES ('22', '18', '2026-10-04', '2026-10-07', '2000-10-07');

-- Rentalitem: (rental_rate >= 0)
-- INSERT INTO Rentalitem (rental_id, equipment_id, rental_rate)
-- VALUES ('20', '104', -85.00);