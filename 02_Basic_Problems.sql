-- Basic:
-- 01. Retrieve the total number of orders placed.
SELECT COUNT(*) AS "total_orders" FROM orders;
############################################################################
-- 02. Calculate the total revenue generated from pizza sales. 
SELECT 
ROUND(SUM(t1.quantity * t2.price),2) AS "total_sales"
FROM order_details t1 
JOIN pizzas t2
ON t2.pizza_id = t1.pizza_id;

############################################################################
-- 03. Identify the highest-priced pizza.
SELECT t1.name, t2.price FROM pizza_types t1
JOIN pizzas t2
ON t1.pizza_type_id = t2.pizza_type_id
ORDER BY t2.price DESC LIMIT 1;

############################################################################
-- 04. Identify the most common pizza size ordered.
SELECT T1.size, COUNT(T2.order_details_id) AS 'order_count'
FROM pizzas T1
JOIN order_details T2
ON T1.pizza_id = T2.pizza_id
GROUP BY T1.size
ORDER BY order_count DESC LIMIT 1;

############################################################################
-- 05. List the top 5 most ordered pizza types along with their quantities.
 
SELECT T1.name, 
SUM(T3.quantity) AS quantity
FROM pizza_types T1
JOIN pizzas T2
ON T1.pizza_type_id = T2.pizza_type_id
JOIN order_details T3
ON T2.pizza_id = T3.pizza_id
GROUP BY T1.NAME
ORDER BY quantity DESC LIMIT 5;