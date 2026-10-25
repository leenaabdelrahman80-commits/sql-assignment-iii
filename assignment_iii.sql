

-- 1. Database Creation
CREATE DATABASE yourname_studentid_vuba_vuba;



-- 2. Table Creation (Parent tables first, then Child table)
CREATE TABLE restaurants (
    restaurant_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine_type VARCHAR(50),
    city VARCHAR(50) DEFAULT 'Kigali'
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    address VARCHAR(150)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    total_amount DECIMAL(10,2) NOT NULL,
    order_date DATE DEFAULT CURRENT_DATE,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_restaurant FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- 3. Initial Data Insertion
INSERT INTO restaurants (name, cuisine_type, city) VALUES 
('Bourbon Coffee', 'Cafe', 'Kigali'),
('Camellia Tea House', 'Bakery & Fast Food', 'Kigali'),
('Sole Luna', 'Italian', 'Kigali'),
('KFC Kigali', 'Fast Food', 'Kigali'),
('Soy Asian Table', 'Asian Fusion', 'Kigali');

INSERT INTO customers (full_name, phone_number, address) VALUES 
('Eric Mugisha', '+250788123456', 'Nyarutarama'),
('Alice Uwase', '+250788654321', 'Kimiwurura'),
('Jean Claude', '+250788999888', 'Remera'),
('Divine Iribagiza', '+250788111222', 'Gacuriro'),
('Patrick Habimana', '+250788444555', 'Kiyovu');

INSERT INTO orders (customer_id, restaurant_id, total_amount, order_date) VALUES 
(1, 1, 12500.00, '2026-10-20'),
(2, 3, 24000.00, '2026-10-21'),
(3, 2, 8500.00, '2026-10-22'),
(4, 4, 15000.00, '2026-10-23'),
(5, 5, 32000.00, '2026-10-24');

-- 4. SQL Practical Tasks

-- 4.1 SELECT Tasks (Data Retrieval)
-- Q1.1: Basic Data Retrieval
SELECT name, cuisine_type FROM restaurants;

-- Q1.2: Conditional Data Retrieval
SELECT * FROM orders WHERE total_amount > 15000.00;

-- Q1.3: Sorted Data Retrieval
SELECT * FROM customers ORDER BY full_name ASC;

-- 4.2 JOIN Tasks (Retrieving Related Data)
-- Q2.1: INNER JOIN
SELECT o.order_id, c.full_name, o.total_amount 
FROM orders o 
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- Q2.2: LEFT JOIN
SELECT r.name, o.order_id, o.total_amount 
FROM restaurants r 
LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id;

-- Q2.3: Multi-Table JOIN
SELECT o.order_id, c.full_name, r.name AS restaurant_name, o.total_amount, o.order_date 
FROM orders o 
INNER JOIN customers c ON o.customer_id = c.customer_id 
INNER JOIN restaurants r ON o.restaurant_id = r.restaurant_id;

-- 4.3 UPDATE Tasks (Modifying Existing Data)
-- Q3.1: Update One Record
UPDATE customers SET address = 'Kigali Heights' WHERE customer_id = 1;
SELECT * FROM customers WHERE customer_id = 1;

-- Q3.2: Update Multiple Records
UPDATE restaurants SET city = 'Kigali City' WHERE city = 'Kigali';
SELECT * FROM restaurants;

-- Q3.3: Conditional Update
UPDATE orders SET total_amount = total_amount * 0.90 WHERE total_amount > 20000.00;
SELECT * FROM orders;

-- 4.4 ALTER TABLE Tasks (Modifying Table Structure)
-- Q4.1: Rename a Column
ALTER TABLE restaurants RENAME COLUMN cuisine_type TO category;
SELECT * FROM restaurants;

-- Q4.2: Change a Column's Data Type
ALTER TABLE customers ALTER COLUMN phone_number TYPE VARCHAR(30);
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'customers';

-- Q4.3: Add a New Column
ALTER TABLE orders ADD COLUMN order_status VARCHAR(20) DEFAULT 'Delivered';
SELECT * FROM orders;

-- 4.5 Additional INSERT Tasks
-- Q5.1: Insert a Single Record
INSERT INTO restaurants (name, category, city) VALUES ('Pili Pili', 'Grill & Lounge', 'Kigali City');

-- Q5.2: Insert Multiple Records
INSERT INTO restaurants (name, category, city) VALUES 
('Zaaffran', 'Indian', 'Kigali City'),
('Meze Fresh', 'Mexican', 'Kigali City');

-- Q5.3: Insert a Related Record
INSERT INTO orders (customer_id, restaurant_id, total_amount, order_date) VALUES (1, 6, 18500.00, '2026-10-25');

-- Final Verification Selects
SELECT * FROM restaurants;
SELECT * FROM customers;
SELECT * FROM orders;