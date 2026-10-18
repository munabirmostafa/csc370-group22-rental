CREATE DATABASE IF NOT EXISTS csc370_sprint1;
USE csc370_sprint1;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY CHECK (customer_id > 0),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(30)
);

CREATE TABLE Category (
    category_id INT PRIMARY KEY CHECK (category_id > 0),
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE Equipment (
    equipment_id INT PRIMARY KEY CHECK (equipment_id > 0),
    category_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    serial_number VARCHAR(100) NOT NULL UNIQUE,
    daily_rate DECIMAL(8 , 2 ) NOT NULL CHECK (daily_rate >= 0),
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (category_id)
        REFERENCES Category (category_id),
	CHECK (status IN (
		'available',
		'rented',
		'maintenance'
	))
);

CREATE TABLE Rental (
    rental_id INT PRIMARY KEY CHECK (rental_id > 0),
    customer_id INT NOT NULL,
    rental_date DATE NOT NULL,
    expected_return_date DATE NOT NULL,
    actual_return_date DATE,
    CHECK (expected_return_date >= rental_date),
    CHECK (actual_return_date >= rental_date OR actual_return_date is NULL),
    FOREIGN KEY (customer_id)
        REFERENCES Customer (customer_id)
);

CREATE TABLE RentalItem (
    rental_id INT NOT NULL,
    equipment_id INT NOT NULL,
    rental_rate DECIMAL(8, 2) NOT NULL CHECK (rental_rate >= 0),
    PRIMARY KEY (rental_id, equipment_id),
    FOREIGN KEY (rental_id) REFERENCES Rental(rental_id),
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id)
);

SELECT
    Customer.name AS customer_name,
    Rental.rental_id,
    Equipment.name AS equipment_name,
    RentalItem.rental_rate
FROM Rental
JOIN Customer
    ON Rental.customer_id = Customer.customer_id
JOIN RentalItem
    ON Rental.rental_id = RentalItem.rental_id
JOIN Equipment
    ON RentalItem.equipment_id = Equipment.equipment_id;
