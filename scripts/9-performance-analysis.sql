-- Performance analysis

/* Analyze the yearly performance of products by comparing each products sales 
to both its average sales performance and the previous year's sales
*/
WITH yearly_products_sales AS
(
	SELECT 
		YEAR(f.order_date) order_year,
		p.product_name,
		SUM(f.sales_amount) current_sales
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
	ON f.product_key=p.product_key
	WHERE order_date IS NOT NULL
	GROUP BY YEAR(f.order_date),p.product_name
)
 SELECT 
	order_year,
	product_name,
	current_sales,
	AVG(current_sales)OVER(PARTITION BY product_name) avg_sales,
	current_sales-AVG(current_sales)OVER(PARTITION BY product_name) diff_avg,
	CASE
		WHEN current_sales-AVG(current_sales)OVER(PARTITION BY product_name) <0 THEN 'Below_average'
		WHEN current_sales-AVG(current_sales)OVER(PARTITION BY product_name) >0 THEN 'Above_average'
		ELSE 'Average'
	END avg_change,
-- year-over-year analysis
	LAG(current_sales,1)OVER(PARTITION BY product_name ORDER BY order_year) py_sales,
	current_sales-LAG(current_sales,1)OVER(PARTITION BY product_name ORDER BY order_year) diff_py,
	CASE
		WHEN current_sales-LAG(current_sales,1)OVER(PARTITION BY product_name ORDER BY order_year) <0 THEN 'decrease'
		WHEN current_sales-LAG(current_sales,1)OVER(PARTITION BY product_name ORDER BY order_year) >0 THEN 'increase'
		ELSE 'no change'
	END py_change
 FROM yearly_products_sales
 ORDER BY product_name,order_year;

 /* Analyze the MONTH performance of products by comparing each products sales 
to both its average sales performance and the previous month's sales
*/
WITH yearly_products_sales AS
(
	SELECT 
		month(f.order_date) order_month,
		p.product_name,
		SUM(f.sales_amount) current_sales
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
	ON f.product_key=p.product_key
	WHERE order_date IS NOT NULL
	GROUP BY month(f.order_date),p.product_name
)
 SELECT 
	order_month,
	product_name,
	current_sales,
	AVG(current_sales)OVER(PARTITION BY product_name) avg_sales,
	current_sales-AVG(current_sales)OVER(PARTITION BY product_name) diff_avg,
	CASE
		WHEN current_sales-AVG(current_sales)OVER(PARTITION BY product_name) <0 THEN 'Below_average'
		WHEN current_sales-AVG(current_sales)OVER(PARTITION BY product_name) >0 THEN 'Above_average'
		ELSE 'Average'
	END avg_change,
-- month-over-month analysis
	LAG(current_sales,1)OVER(PARTITION BY product_name ORDER BY order_month) py_sales,
	current_sales-LAG(current_sales,1)OVER(PARTITION BY product_name ORDER BY order_month) diff_py,
	CASE
		WHEN current_sales-LAG(current_sales,1)OVER(PARTITION BY product_name ORDER BY order_month) <0 THEN 'decrease'
		WHEN current_sales-LAG(current_sales,1)OVER(PARTITION BY product_name ORDER BY order_month) >0 THEN 'increase'
		ELSE 'no change'
	END py_change
 FROM yearly_products_sales
 ORDER BY product_name,order_month;