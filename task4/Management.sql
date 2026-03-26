-- ==============================
-- 1. CREATE DATABASE
-- ==============================
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE DATABASE IF NOT EXISTS order_management;
USE order_management;


-- ==============================
-- 2. CREATE TABLES
-- ==============================

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);


-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);


-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- ==============================
-- 3. INSERT SAMPLE DATA
-- ==============================

-- Insert Customers
INSERT INTO customers (name,email) VALUES
('Pavan','pavan@gmail.com'),
('Rahul','rahul@gmail.com'),
('Anitha','anitha@gmail.com'),
('Kiran','kiran@gmail.com'),
('Sneha','sneha@gmail.com');


-- Insert Products
INSERT INTO products (product_name,price) VALUES
('Laptop',60000),
('Mobile',20000),
('Headphones',3000),
('Keyboard',1500),
('Mouse',800);


-- Insert Orders
INSERT INTO orders (customer_id,product_id,quantity,order_date) VALUES
(1,1,1,'2026-03-01'),
(1,3,2,'2026-03-02'),
(2,2,1,'2026-03-03'),
(3,3,3,'2026-03-04'),
(4,4,1,'2026-03-05'),
(5,5,2,'2026-03-06'),
(2,3,1,'2026-03-07'),
(3,2,2,'2026-03-08');


-- ==============================
-- 4. DISPLAY CUSTOMER ORDER HISTORY (JOIN)
-- ==============================

SELECT 
    customers.name AS customer_name,
    products.product_name,
    orders.quantity,
    products.price,
    (orders.quantity * products.price) AS total_price,
    orders.order_date
FROM orders
JOIN customers 
ON orders.customer_id = customers.customer_id
JOIN products 
ON orders.product_id = products.product_id
ORDER BY orders.order_date DESC;


-- ==============================
-- 5. HIGHEST VALUE ORDER (SUBQUERY)
-- ==============================

SELECT *
FROM (
    SELECT 
        customers.name,
        products.product_name,
        orders.quantity,
        products.price,
        (orders.quantity * products.price) AS total_price
    FROM orders
    JOIN customers 
    ON orders.customer_id = customers.customer_id
    JOIN products 
    ON orders.product_id = products.product_id
) AS order_values
WHERE total_price = (
    SELECT MAX(quantity * price)
    FROM orders
    JOIN products 
    ON orders.product_id = products.product_id
);


-- ==============================
-- 6. MOST ACTIVE CUSTOMER (SUBQUERY)
-- ==============================

SELECT name, order_count
FROM (
    SELECT 
        customers.name,
        COUNT(orders.order_id) AS order_count
    FROM orders
    JOIN customers 
    ON orders.customer_id = customers.customer_id
    GROUP BY customers.name
) AS customer_orders
WHERE order_count = (
    SELECT MAX(order_count)
    FROM (
        SELECT COUNT(order_id) AS order_count
        FROM orders
        GROUP BY customer_id
    ) AS temp
);


-- ==============================
-- 7. CUSTOMER TOTAL SPENDING
-- ==============================

SELECT 
    customers.name,
    SUM(orders.quantity * products.price) AS total_spent
FROM orders
JOIN customers 
ON orders.customer_id = customers.customer_id
JOIN products 
ON orders.product_id = products.product_id
GROUP BY customers.name
ORDER BY total_spent DESC;


-- ==============================
-- 8. TOTAL PRODUCTS SOLD
-- ==============================

SELECT 
    products.product_name,
    SUM(orders.quantity) AS total_sold
FROM orders
JOIN products 
ON orders.product_id = products.product_id
GROUP BY products.product_name
ORDER BY total_sold DESC;