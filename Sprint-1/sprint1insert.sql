USE csc370_sprint1;

-- Constraints to check:
-- Customer: (customer_id > 0)
-- Equipment: (daily_rate >= 0)
-- Equipment: (status IN ('available', 'rented', 'maintenance'))
-- Rental: (expected_return_date >= rental_date),
-- Rental: (actual_return_date IS NULL OR actual_return_date >= rental_date)
-- RentalItem: (rental_rate >= 0)


-- VALID INSERTS

-- INSERT CATEGORY
INSERT INTO Category (category_id, category_name)
VALUES
    (2, 'camera'),
    (3, 'microphone'),
    (4, 'lighting'),
    (5, 'support');

-- INSERT EQUIPMENT
INSERT INTO Equipment (equipment_id, name, serial_number, daily_rate, status, category_id)
VALUES
    (104, 'Sony FX3', 'XYZ3000', 85.00, 'rented', 2),
    (105, 'Rode NTG5', 'MIC3001', 25.00, 'rented', 3),
    (106, 'Aputure light', 'LGT3002', 40.00, 'available', 4),
    (107, 'Manfrotto tripod', 'SUP3003', 15.00, 'available', 5),
    (108, 'Canon EOS R5', 'CAM3004', 60.00, 'maintenance', 2),
    (109, 'Sony A7 III', 'CAM3005', 55.00, 'rented', 2);

-- INSERT CUSTOMER
INSERT INTO Customer (customer_id, name, email, phone)
VALUES
    (18, 'Sarah Smith', 'sarah@example.com', '250-555-1234'),
    (19, 'Alex Chen', 'alex@example.com', '250-555-2345'),
    (20, 'Danny Lee', 'danny@example.com', '250-555-3456'),
    (21, 'Mina Rahman', 'mina@example.com', '250-555-4567');

-- INSERT RENTAL
INSERT INTO Rental (rental_id, customer_id, rental_date, expected_return_date, actual_return_date)
VALUES
    (20, 18, '2026-10-04', '2026-10-07', NULL),
    (21, 18, '2026-09-20', '2026-09-22', '2026-09-22'),
    (22, 20, '2026-10-01', '2026-10-03', '2026-10-03'),
    (23, 19, '2026-10-17', '2026-10-20', NULL);

-- INSERT RENTAL ITEM
INSERT INTO RentalItem (rental_id, equipment_id, rental_rate)
VALUES
    (20, 104, 85.00),
    (20, 105, 25.00),
    (21, 104, 80.00),
    (21, 106, 35.00),
    (22, 107, 15.00),
    (23, 109, 55.00);


-- NOT VALID INSERTS

-- Equipment: (daily_rate >= 0)
-- INSERT INTO Equipment (equipment_id, name, serial_number, daily_rate, status, category_id)
-- VALUES (9001, 'Sony FX3', 'XYZ4000', -85.00, 'available', 2);

-- Equipment: (status IN ('available', 'rented', 'maintenance'))
-- INSERT INTO Equipment (equipment_id, name, serial_number, daily_rate, status, category_id)
-- VALUES (9002, 'Sony FX3', 'XYZ5000', 85.00, 'abailable', 2);

-- Rental: (expected_return_date >= rental_date)
-- INSERT INTO Rental (rental_id, customer_id, rental_date, expected_return_date, actual_return_date)
-- VALUES (9003, 18, '2026-10-04', '1000-10-07', NULL);

-- Rental: (actual_return_date IS NULL OR actual_return_date >= rental_date)
-- INSERT INTO Rental (rental_id, customer_id, rental_date, expected_return_date, actual_return_date)
-- VALUES (9004, 18, '2026-10-04', '2026-10-07', '2000-10-07');

-- RentalItem: (rental_rate >= 0)
-- INSERT INTO RentalItem (rental_id, equipment_id, rental_rate)
-- VALUES (20, 106, -85.00);
