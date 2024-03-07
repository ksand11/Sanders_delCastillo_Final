CREATE DATABASE Sanders_delCastillo_db
GO

--- Tables ---


-- Create Customers table
CREATE TABLE Customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone CHAR(10),
    is_deleted BIT DEFAULT 0
);
ALTER TABLE Customers
ADD CONSTRAINT customers_chk_phone_number_format CHECK (LEN(phone) = 10);
ALTER TABLE Customers
ADD CONSTRAINT customers_chk_email_format CHECK (email LIKE '%_@_%._%');


-- Create Employees table
CREATE TABLE Employees (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone CHAR(10),
    pay_rate DECIMAL(10, 2),
    hire_date DATE,
	discount DECIMAL(5, 2),
	is_manager BIT,
    is_deleted BIT DEFAULT 0
);
ALTER TABLE Employees
ADD CONSTRAINT employees_chk_phone_number_format CHECK (LEN(phone) = 10);
ALTER TABLE Employees
ADD CONSTRAINT employees_chk_email_format CHECK (email LIKE '%_@_%._%');

-- Create Records table
CREATE TABLE Records (
    record_id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(100),
    artist VARCHAR(100),
    year INT,
    genre VARCHAR(50),
    album VARCHAR(100),
    price DECIMAL(10, 2),
    stock INT,
    sales_count INT,
	is_deleted BIT DEFAULT 0
);

-- Create Sales table
CREATE TABLE Sales (
    sale_id INT IDENTITY(1,1) PRIMARY KEY,
    record_id INT,
    buyer_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    date DATE,
    FOREIGN KEY (record_id) REFERENCES Records(record_id),
    FOREIGN KEY (buyer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (buyer_id) REFERENCES Employees(employee_id),
);

GO


--- Sample Data ---


-- Customers
INSERT INTO Customers (first_name, last_name, email, phone)
VALUES 
('Alice', 'Johnson', 'alice@example.com', '1234567890'),
('Bob', 'Smith', 'bob@example.com', '9876543210'),
('Charlie', 'Brown', 'charlie@example.com', '4561237890'),
('David', 'Lee', 'david@example.com', '7894561230'),
('Emma', 'Wilson', 'emma@example.com', '3216549870');

-- Employees
INSERT INTO Employees (first_name, last_name, email, phone, pay_rate, hire_date, discount, is_manager)
VALUES
('John', 'Doe', 'john@example.com', '1112223333', 15.00, '2023-01-15', 0.05, 1),
('Jane', 'Smith', 'jane@example.com', '4445556666', 14.00, '2022-08-20', 0.03, 0),
('Michael', 'Johnson', 'michael@example.com', '7778889999', 16.50, '2023-03-10', 0.07, 1),
('Emily', 'Brown', 'emily@example.com', '9998887777', 13.75, '2021-12-05', 0.02, 0),
('William', 'Wilson', 'william@example.com', '6665554444', 15.25, '2022-05-03', 0.06, 0);

-- Records
INSERT INTO Records (title, artist, year, genre, album, price, stock, sales_count)
VALUES 
('Thriller', 'Michael Jackson', 1982, 'Pop', 'Thriller', 9.99, 100, 50),
('Abbey Road', 'The Beatles', 1969, 'Rock', 'Abbey Road', 12.99, 75, 40),
('Dark Side of the Moon', 'Pink Floyd', 1973, 'Progressive Rock', 'Dark Side of the Moon', 11.49, 120, 55),
('Back in Black', 'AC/DC', 1980, 'Hard Rock', 'Back in Black', 10.99, 90, 60),
('Led Zeppelin IV', 'Led Zeppelin', 1971, 'Rock', 'Led Zeppelin IV', 13.49, 85, 45);

-- Sales
INSERT INTO Sales (record_id, buyer_id, quantity, price, date)
VALUES
(1, 1, 2, 19.98, '2023-02-05'),
(3, 2, 1, 11.49, '2023-03-15'),
(2, 3, 3, 38.97, '2023-01-20'),
(4, 4, 4, 43.96, '2023-04-10'),
(5, 5, 2, 26.98, '2023-05-01');

GO

--- Scenarios ---

/*
-- Search for Records
SELECT * FROM Records
WHERE title LIKE '%Title%'
OR artist LIKE '%Artist%'
OR year = 1990
OR genre LIKE '%Genre%'
OR album LIKE '%Album%'
AND is_deleted = 0;

-- Sign up for membership (Add a new Customer)
INSERT INTO Customers (first_name, last_name, email, phone)
VALUES ('John', 'Smith', 'email@email.com', '0000000000');

-- Login
(SELECT customer_id, first_name, last_name FROM Customers WHERE Phone = '0000000000' OR Email = 'email@email.com')
UNION
(SELECT employee_id, first_name, last_name FROM Employees WHERE Phone = '0000000000' OR Email = 'email@email.com')
WHERE is_deleted = 0;

-- Employee Discount
UPDATE Records
SET price = price * (1 - .01 * 
	(SELECT discount FROM Employees	WHERE employee_id = 1))
WHERE record_id = 1;

-- Change Inventory --

-- Add new record
INSERT INTO Records (title, artist, year, genre, album, price, stock, sales_count)
VALUES ('Title', 'Artist', 1990, 'Genre', 'Album', 19.99, 5, 0);

-- Remove existing record
UPDATE Records
SET is_deleted = 1
WHERE record_id = 1;

-- Update stock
UPDATE Records
SET stock = 50
WHERE record_id = 1
AND is_deleted = 0;

-- Check stock
SELECT stock FROM Records
WHERE record_id = 1
AND is_deleted  = 0;

-- Add new Sale
INSERT INTO Sales (record_id, buyer_id, quantity, price, date)
VALUES (1, 1, 4, 79.96, '2013-01-01');

GO


--- Queries ---


-- Search for out of stock Records
SELECT * FROM Records
WHERE stock = 0
AND is_deleted = 0;

-- Search for Records with high sales
SELECT * FROM Records
WHERE sales_count > 15
AND is_deleted = 0
ORDER BY sales_count DESC;

-- Delete a Customer
DELETE FROM Customers
WHERE customer_id = 1
AND is_deleted = 0;

-- Apply a discount
UPDATE Records
SET price = price * (1 - .01 * 
	(SELECT discount FROM Employees	WHERE employee_id = 1))
WHERE record_id = 1
AND is_deleted = 0;

-- Add a new Record into stock
INSERT INTO Records (title, artist, year, genre, album, price, stock, sales_count)
VALUES ('Title', 'Artist', 1990, 'Genre', 'Album', 19.99, 5, 0);

GO
*/