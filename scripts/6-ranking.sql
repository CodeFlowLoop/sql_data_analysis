-- Ranking 
-- Which 5 products generate the highest revenue
SELECT TOP 5
	p.product_name,
	SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
	ON f.product_key=p.product_key
GROUP BY p.product_name
ORDER BY  total_revenue DESC;

-- Complex but Flexibly Ranking Using Window Functions
SELECT * 
FROM(
	SELECT 
		p.product_name,
		SUM(f.sales_amount) total_revenue,
		RANK() OVER(ORDER BY SUM(f.sales_amount) DESC) rn_revenue
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
		ON f.product_key=p.product_key
	GROUP BY p.product_name)t
WHERE rn_revenue <=5

-- What are the 5  worst performing products in terms of sales
SELECT TOP 5
	p.product_name,
	SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
	ON f.product_key=p.product_key
GROUP BY p.product_name
ORDER BY  total_revenue ;

-- What are the 5  worst performing products sub-category  in terms of sales
SELECT TOP 5
	p.subcategory,
	SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
	ON f.product_key=p.product_key
GROUP BY p.subcategory
ORDER BY  total_revenue ;

-- Find the top 10 customers who have generated the higest revenue
SELECT TOP 10
	c.customer_key,
	c.first_name,
	c.last_name,
	SUM(f.sales_amount)	total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
	ON f.customer_key=c.customer_key
GROUP BY c.customer_key,
	c.first_name,
	c.last_name
ORDER BY total_revenue DESC;

-- Find the 3 customers with the fewest orders placed
SELECT TOP 3
	c.customer_key,
	c.first_name,
	c.last_name,
	COUNT(order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
	ON f.customer_key=c.customer_key
GROUP BY c.customer_key,
	c.first_name,
	c.last_name
ORDER BY total_orders;