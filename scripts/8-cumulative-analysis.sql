-- Cumulative analysis

-- Calculate the total sales per month and
--  The running total of sales over time

SELECT 
	order_dates,
	total_sales,
	-- window_functions
	SUM(total_sales) OVER(ORDER BY order_dates ) running_total,
	SUM(total_sales) OVER(PARTITION BY order_dates ORDER BY order_dates ) running_total_year
FROM (
	SELECT 
		DATETRUNC(MONTH,order_date) order_dates,
		SUM(sales_amount) total_sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(MONTH,order_date)
	) t;

-- Calculate the total sales per Year and
--  The running total of sales over time

SELECT 
	order_dates,
	total_sales,
	-- window_functions
	SUM(total_sales) OVER(ORDER BY order_dates ) running_total
FROM (
	SELECT 
		DATETRUNC(YEAR ,order_date) order_dates,
		SUM(sales_amount) total_sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(YEAR,order_date)
	) t;

-- Calculate the avg total sales per Year and
--  The avg running  total of sales over time
SELECT 
	order_dates,
	total_sales,
	-- window_functions
	SUM(total_sales) OVER(ORDER BY order_dates ) running_total,
	AVG(avg_sales) OVER(ORDER BY order_dates ) moving_avg_price
FROM (
	SELECT 
		DATETRUNC(YEAR ,order_date) order_dates,
		SUM(sales_amount) total_sales,
		avg(sales_amount) avg_sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(YEAR,order_date)
	) t;