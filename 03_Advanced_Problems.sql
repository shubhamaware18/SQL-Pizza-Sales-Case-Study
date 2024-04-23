-- Advanced Qns:
-- USE pizzahut;
############################################################################
-- 01. Calculate the percentage contribution of 
-- each pizza type to total revenue.
SELECT T1.category AS 'category',
ROUND(SUM(T3.quantity * T2.price)/ (SELECT 
							ROUND(SUM(t1.quantity * t2.price),2) AS "total_sales"
		FROM order_details t1 
				JOIN pizzas t2
				ON t2.pizza_id = t1.pizza_id)* 100,2)  AS 'revenue'
FROM pizza_types T1
JOIN pizzas T2
ON T1.pizza_type_id = T2.pizza_type_id
join order_details T3
ON T3.pizza_id = T2.pizza_id
GROUP BY category
ORDER BY revenue DESC;

############################################################################
-- 02. Analyze the cumulative revenue generated over time.
SELECT date,
ROUND(SUM(revenue) OVER(ORDER BY date),3) AS "cum_sum"
FROM
    (SELECT T3.order_date AS 'date',
    SUM(T1.quantity * T2.price) AS 'revenue' 
    FROM order_details T1
    JOIN pizzas T2
    ON T1.pizza_id = T2.pizza_id
    JOIN orders T3
    ON T3.order_id = T1.order_id
    GROUP BY date) AS sales;
    
############################################################################
-- 03. Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT name,revenue,category FROM
(SELECT category, name, revenue,
RANK() OVER(PARTITION BY category ORDER BY revenue DESC) AS rn
	FROM (SELECT pizza_types.category,
		pizza_types.name,
		SUM(order_details.quantity * pizzas.price) AS 'revenue'
		FROM pizza_types
		JOIN pizzas
		ON pizza_types.pizza_type_id = pizzas.pizza_type_id
		JOIN order_details
		ON order_details.pizza_id = pizzas.pizza_id
		GROUP BY pizza_types.category, pizza_types.name) AS a) AS b
WHERE rn <=3;