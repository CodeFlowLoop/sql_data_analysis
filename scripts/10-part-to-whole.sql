-- part-to-whole (proportional)

-- Which categories contributen the most to overall sales
WITH category_sales AS
(
	SELECT 
		category,
		SUM(f.sales_amount) total_sales
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
	ON f.product_key=p.product_key
	GROUP BY category
)
SELECT
	category,
	total_sales,
	SUM(total_sales) OVER() overall_sales ,
	CONCAT(ROUND((CAST(total_sales AS FLOAT)/SUM(total_sales) OVER())*100,2),'%')AS percentage_of_sales
FROM category_sales