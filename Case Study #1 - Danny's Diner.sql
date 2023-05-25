-- What is the total amount each customer spent at the restaurant?

SELECT DISTINCT customer_id, SUM(price) AS total_amount
FROM sales
JOIN menu
ON sales.product_id = menu.product_id
GROUP BY customer_id;

-- How many days has each customer visited the restaurant?

SELECT customer_id, COUNT(order_date)
FROM sales
GROUP BY customer_id;

-- What was the first item from the menu purchased by each customer?

SELECT DISTINCT s.customer_id, m.product_name, MIN(s.order_date) AS first_purchase_date
FROM sales s
JOIN menu m
ON s.product_id = m.product_id
GROUP BY s.customer_id, m.product_name;

-- What is the most purchased item on the menu and how many times was it purchased by all customers?

SELECT m.product_name, COUNT(s.product_id) AS number_of_purchase
FROM menu m
JOIN sales s
ON m.product_id = s.product_id
GROUP BY product_name
ORDER BY number_of_purchase DESC
LIMIT 1;

-- Which item was the most popular for each customer?

SELECT s.customer_id, m.product_name, COUNT(s.product_id) AS highest_number_of_purchase
FROM menu m
JOIN sales s
ON m.product_id = s.product_id
GROUP BY customer_id, product_name
ORDER BY highest_number_of_purchase DESC;

-- Which item was purchased first by the customer after they became a member?

SELECT s.customer_id, m.product_name, MIN(s.order_date) AS first_purchase_date
FROM sales s
JOIN menu m
ON s.product_id = m.product_id
JOIN members m2
ON s.customer_id = m2.customer_id
WHERE s.order_date >= m2.join_date
GROUP BY customer_id, product_name
ORDER BY first_purchase_date;

-- Which item was purchased just before the customer became a member?

SELECT s.customer_id, m.product_name, MIN(s.order_date) AS first_purchase_date
FROM sales s
JOIN menu m
ON s.product_id = m.product_id
JOIN members m2
ON s.customer_id = m2.customer_id
WHERE s.order_date < m2.join_date
GROUP BY customer_id, product_name
ORDER BY first_purchase_date;

-- What is the total items and amount spent for each member before they became a member?

SELECT s.customer_id, COUNT(s.product_id) AS total_items, SUM(m.price) AS total_price
FROM  sales s
JOIN menu m
ON s.product_id = m.product_id
JOIN members m2
ON s.customer_id = m2.customer_id
WHERE s.order_date < m2.join_date
GROUP BY customer_id;

-- If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

SELECT s.customer_id, SUM(m.price * (10 + (m.product_id = 2) *2)) AS total_points
FROM sales s
JOIN menu m
ON s.product_id = m.product_id
GROUP BY customer_id;


-- In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

