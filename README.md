# Assignment III: SQL Table Manipulation
**Institution:** Kigali Independent University (ULK)  
**Course:** Database Management Systems  
**Instructor:** Eric Maniraguha  

---

## Section 1: Project Overview
* **Project Title:** Vuba Vuba Delivery System Database
* **Student Name:** Lena Abdelrahman
* **Student ID:** 202510416
* **Chosen Business Idea:** Vuba Vuba Delivery Platform (Food & Goods Delivery)
* **Selected DBMS:** PostgreSQL

---

## Section 2: Database and Table Design
* **Database Name:** lenaabdelrahman_202510416_vuba_vuba`
* **Tables and Purposes:**
  1. `restaurants`: Stores information about partner restaurants (Parent table).
  2. `customers`: Stores user profiles and delivery contact details (Parent table).
  3. `orders`: Tracks delivery orders connecting customers and restaurants (Child table).
* **Relationships:** 
  * A One-to-Many relationship exists between `customers` and `orders` (One customer can place multiple orders).
  * A One-to-Many relationship exists between `restaurants` and `orders` (One restaurant can receive multiple orders).
* **Primary & Foreign Keys:**
  * Auto-generated primary keys: `restaurant_id`, `customer_id`, and `order_id`.
  * Foreign key `orders.customer_id` references `customers.customer_id`.
  * Foreign key `orders.restaurant_id` references `restaurants.restaurant_id`.

* **Entity-Relationship Diagram (ERD):**
![ERD](erd.png)

---

## Section 3: Database and Table Creation
```sql
CREATE DATABASE yourname_studentid_vuba_vuba;

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
Section 5: SQL Practical Tasks
5.1 SELECT Tasks
Q1.1: Basic Data Retrieval

Objective: Retrieve restaurant names and their categories.

SQL Statement: SELECT name, cuisine_type FROM restaurants;

Explanation: Displays basic attributes of partner restaurants.

Q1.2: Conditional Data Retrieval

Objective: Retrieve delivery orders exceeding 15,000 RWF.

SQL Statement: SELECT * FROM orders WHERE total_amount > 15000.00;

Explanation: Filters orders based on a total price condition.

Q1.3: Sorted Data Retrieval

Objective: Retrieve customers arranged alphabetically by full name.

SQL Statement: SELECT * FROM customers ORDER BY full_name ASC;

Explanation: Sorts customer records in ascending alphabetical order.

5.2 JOIN Tasks
Q2.1: INNER JOIN

Objective: Retrieve orders linked with customer names.

SQL Statement:

SQL
SELECT o.order_id, c.full_name, o.total_amount 
FROM orders o 
INNER JOIN customers c ON o.customer_id = c.customer_id;
Explanation: Joins child table orders with parent table customers based on matching IDs.

Q2.2: LEFT JOIN

Objective: Display all restaurants and any corresponding orders.

SQL Statement:

SQL
SELECT r.name, o.order_id, o.total_amount 
FROM restaurants r 
LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id;
Explanation: Shows all entries from restaurants even if no matching order exists.

Q2.3: Multi-Table JOIN

Objective: Produce a full report combining orders, customers, and restaurants.

SQL Statement:

SQL
SELECT o.order_id, c.full_name, r.name AS restaurant_name, o.total_amount, o.order_date 
FROM orders o 
INNER JOIN customers c ON o.customer_id = c.customer_id 
INNER JOIN restaurants r ON o.restaurant_id = r.restaurant_id;
Explanation: Combines three tables to generate a comprehensive business report.

5.3 UPDATE Tasks
Q3.1: Update One Record

Objective: Modify the address of customer ID 1.

SQL Statement: UPDATE customers SET address = 'Kigali Heights' WHERE customer_id = 1;

Verification Query: SELECT * FROM customers WHERE customer_id = 1;

Explanation: Updates a specific customer's delivery address using their primary key.

Q3.2: Update Multiple Records

Objective: Standardize city names for restaurants.

SQL Statement: UPDATE restaurants SET city = 'Kigali City' WHERE city = 'Kigali';

Verification Query: SELECT * FROM restaurants;

Explanation: Updates multiple restaurant entries matching the location condition.

Q3.3: Conditional Update

Objective: Apply a 10% discount to orders greater than 20,000 RWF.

SQL Statement: UPDATE orders SET total_amount = total_amount * 0.90 WHERE total_amount > 20000.00;

Verification Query: SELECT * FROM orders;

Explanation: Modifies column values based on a promotional business logic rule.

5.4 ALTER TABLE Tasks
Q4.1: Rename a Column

Objective: Rename column cuisine_type to category in restaurants.

SQL Statement: ALTER TABLE restaurants RENAME COLUMN cuisine_type TO category;

Verification Query: SELECT * FROM restaurants;

Explanation: Renames a table column while preserving existing records.

Q4.2: Change a Column's Data Type

Objective: Expand character capacity for phone_number.

SQL Statement: ALTER TABLE customers ALTER COLUMN phone_number TYPE VARCHAR(30);

Verification Query: SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'customers';

Explanation: Alters structural data type definition safely.

Q4.3: Add a Column

Objective: Add an order_status column to track delivery status.

SQL Statement: ALTER TABLE orders ADD COLUMN order_status VARCHAR(20) DEFAULT 'Delivered';

Verification Query: SELECT * FROM orders;

Explanation: Adds a new column field to the existing structure.

5.5 Additional INSERT Tasks
Q5.1: Insert a Single Record

Objective: Insert a single new restaurant.

SQL Statement: INSERT INTO restaurants (name, category, city) VALUES ('Pili Pili', 'Grill & Lounge', 'Kigali City');

Q5.2: Insert Multiple Records

Objective: Insert multiple new restaurants simultaneously.

SQL Statement: INSERT INTO restaurants (name, category, city) VALUES ('Zaaffran', 'Indian', 'Kigali City'), ('Meze Fresh', 'Mexican', 'Kigali City');

Q5.3: Insert a Related Record

Objective: Insert a new order linked to an existing customer and restaurant.

SQL Statement: INSERT INTO orders (customer_id, restaurant_id, total_amount, order_date) VALUES (1, 6, 18500.00, '2026-10-25');

Section 6: Conclusion
In this assignment, I learned how to create relational databases, enforce relational integrity using primary and foreign key constraints, populate data, retrieve filtered data using SELECT queries, combine multi-table datasets via JOINs, safely update records, and dynamically modify database structures using ALTER TABLE operations.
