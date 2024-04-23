-- Intermediate:
USE pizzahut;
############################################################################
-- 01. Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT T1.category,
SUM(T3.quantity) AS "quantity" 
FROM pizza_types T1
JOIN pizzas T2
ON T1.pizza_type_id = T2.pizza_type_id
JOIN order_details T3
ON T3.pizza_id = T2.pizza_id
GROUP BY T1.category
ORDER BY quantity DESC;

############################################################################
-- 02. Determine the distribution of orders by hour of the day.
SELECT HOUR(order_time) AS "hour",
COUNT(order_id) AS "order_count"
FROM orders
GROUP BY hour;

############################################################################
-- 03. Join relevant tables to find the category-wise distribution of pizzas.
SELECT category, COUNT(name) FROM pizza_types
GROUP BY category;

############################################################################
-- 04. Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT ROUND(AVG(quantity),0)  AS "pizzas ordered per day" 
FROM (SELECT orders.order_date, SUM(order_details.quantity) AS quantity
FROM orders JOIN order_details
ON orders.order_id = order_details.order_id
GROUP BY orders.order_date) AS order_quenry;

############################################################################
-- 05. Determine the top 3 most ordered pizza types based on revenue.
SELECT T1.name AS 'name',
SUM(T3.quantity * T2.price) AS 'revenue'  
FROM pizzahut.pizza_types T1
JOIN pizzahut.pizzas T2
ON T1.pizza_type_id = T2.pizza_type_id
JOIN pizzahut.order_details T3
ON T3.pizza_id = T2.pizza_id
GROUP BY name
ORDER BY revenue DESC LIMIT 3;