-- Date exploration
-- Find the date of the first and last order
-- How many years of sales are avaiable
SELECT 
	MIN(order_date) first_order_date,
	MAX(order_date) last_order_date,
	DATEDIFF(YEAR,MIN(order_date),MAX(order_date)) order_range_year
FROM gold.fact_sales;

-- How many Month of sales are avaiable
SELECT 
	DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) order_range_month
FROM gold.fact_sales;

-- Find the youngest and oldest customer
SELECT 
	MIN(birthdate) oldest_birthdate,
	DATEDIFF(YEAR ,MIN(birthdate),GETDATE()) oldest_age,
	MAX(birthdate) youngest_birthdate,
	DATEDIFF(YEAR ,MAX(birthdate),GETDATE()) youngest_age
FROM gold.dim_customers;