-- Change-over-time
-- Analyze sales performance over-time
-- year
SELECT 
YEAR(order_date) orders_years,
SUM(sales_amount) total_sales,
COUNT(DISTINCT customer_key) total_customers,
SUM(quantity) total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY 1

--Month
SELECT 
	DATENAME(MONTH,(order_date)) orders_month,
	SUM(sales_amount) total_sales,
	COUNT(DISTINCT customer_key) total_customers,
	SUM(quantity) total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATENAME(MONTH,(order_date))
ORDER BY 1

-- Year and month
SELECT 
	YEAR(order_date) orders_year,
	MONTH(order_date) orders_month,
	SUM(sales_amount) total_sales,
	COUNT(DISTINCT customer_key) total_customers,
	SUM(quantity) total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date) ,MONTH(order_date)
ORDER BY 1,2;

-- year and month trun
SELECT 
	DATETRUNC(MONTH,order_date) order_date,
	SUM(sales_amount) total_sales,
	COUNT(DISTINCT customer_key) total_customers,
	SUM(quantity) total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)
ORDER BY DATETRUNC(MONTH,order_date);

-- YAER and MONTH using fromate
SELECT 
	FORMAT(order_date,'yyyy-MMM') order_date,
	SUM(sales_amount) total_sales,
	COUNT(DISTINCT customer_key) total_customers,
	SUM(quantity) total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date,'yyyy-MMM')
ORDER BY FORMAT(order_date,'yyyy-MMM');
