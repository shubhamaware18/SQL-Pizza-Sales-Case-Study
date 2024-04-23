-- CREATE DATABASE pizzahut;

-- create table for orders
-- USE pizzahut;
CREATE TABLE orders (
order_id INTEGER NOT NULL,
order_date DATETIME NOT NULL,
order_time TIME NOT NULL,
PRIMARY KEY (order_id)
);

-- create table for orders_details
CREATE TABLE order_details(
order_details_id INTEGER NOT NULL,
order_id INTEGER NOT NULL,
pizza_id TEXT NOT NULL,
quantity INTEGER NOT NULL,
PRIMARY KEY (order_details_id)
);