/* Author   - Sonali Gupta
 Tool Used  - Microsoft SQL Server Management Studio
 Created On - January 2023 */

    SELECT * FROM sales ;
    SELECT * FROM menu ;
    SELECT * FROM members ;


/* What is the total amount each customer spent at the restaurant? */

    SELECT s.customer_id, SUM(price) AS total_sales
    FROM sales AS s
    JOIN menu AS m
    ON s.product_id = m.product_id
    GROUP BY customer_id; 

/* How many days has each customer visited the restaurant? */

    SELECT customer_id, 
    COUNT(DISTINCT(order_date)) AS count_visit
    FROM sales
    GROUP BY customer_id;

/* What was the first item from the menu purchased by each customer? */

WITH sale_rankings AS
    (
    SELECT customer_id, order_date, product_name,
    DENSE_RANK() OVER (PARTITION BY sales.customer_id ORDER BY sales.order_date) AS order_rank
    FROM sales JOIN menu ON sales.product_id = menu.product_id
    )
    SELECT customer_id, product_name
    FROM sale_rankings
    WHERE order_rank = 1
    GROUP BY customer_id, product_name
    

/* What is the most purchased item on the menu and how many times was it purchased by all customers? */

    SELECT TOP 1  product_name, (COUNT(s.product_id)) AS most_purchased
    FROM sales AS s
    JOIN menu AS m
    ON s.product_id = m.product_id
    GROUP BY product_name,s.product_id
    ORDER BY most_purchased DESC;

/* Which item was the most popular for each customer? */

    WITH fav_item_cte AS
    (
    SELECT s.customer_id, m.product_name, 
    COUNT(m.product_id) AS order_count,
    DENSE_RANK() OVER(PARTITION BY s.customer_id
    ORDER BY COUNT(s.customer_id) DESC) AS rank
    FROM menu AS m
    JOIN sales AS s
    ON m.product_id = s.product_id
    GROUP BY s.customer_id, m.product_name
    )
	SELECT customer_id, product_name, order_count
    FROM fav_item_cte 
    WHERE rank = 1;

/* Which item was purchased first by the customer after they became a member? */

	WITH member_sales_cte AS 
    (
      SELECT s.customer_id, m.join_date, s.order_date,   s.product_id,
      DENSE_RANK() OVER(PARTITION BY s.customer_id
      ORDER BY s.order_date) AS ranking
      FROM sales AS s
      JOIN members AS m
      ON s.customer_id = m.customer_id
     WHERE s.order_date >= m.join_date
    )
    SELECT s.customer_id, m2.product_name 
    FROM member_sales_cte AS s
    JOIN menu AS m2
    ON s.product_id = m2.product_id
    WHERE ranking = 1;

/* Which item was purchased just before the customer became a member? */

   WITH prior_member_purchased_cte AS 
 (
   SELECT s.customer_id, m.join_date, s.order_date, s.product_id,
   DENSE_RANK() OVER(PARTITION BY s.customer_id
   ORDER BY s.order_date DESC) AS rank
   FROM sales AS s
   JOIN members AS m
   ON s.customer_id = m.customer_id
   WHERE s.order_date < m.join_date
 )
  SELECT s.customer_id,m2.product_name 
  FROM prior_member_purchased_cte AS s
  JOIN menu AS m2
  ON s.product_id = m2.product_id
  WHERE rank = 1;

/* What is the total items and amount spent for each member before they became a member? */

  SELECT s.customer_id,
  COUNT(DISTINCT s.product_id) AS unique_menu_item, 
  SUM(mm.price) AS total_sales
  FROM sales AS s
  JOIN members AS m
  ON s.customer_id = m.customer_id
  JOIN menu AS mm
  ON s.product_id = mm.product_id
  WHERE s.order_date < m.join_date
  GROUP BY s.customer_id;

/* If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have? */

    WITH price_points_cte AS
 (
 SELECT *, 
 CASE
  WHEN product_id = 1 THEN price * 20
  ELSE price * 10
  END AS points
 FROM menu
 )
 SELECT s.customer_id, SUM(p.points) AS total_points
 FROM price_points_cte AS p
 JOIN sales AS s
 ON p.product_id = s.product_id
 GROUP BY s.customer_id

 /* Join All The Things recreate the table with: customer_id, order_date, product_name, price, member (Y/N) */

   SELECT s.customer_id, s.order_date, m.product_name, m.price,
   CASE
   WHEN mm.join_date > s.order_date THEN 'N'
   WHEN mm.join_date <= s.order_date THEN 'Y'
   ELSE 'N'
   END AS member
   FROM sales AS s
   LEFT JOIN menu AS m
   ON s.product_id = m.product_id
   LEFT JOIN members AS mm
   ON s.customer_id = mm.customer_id;

