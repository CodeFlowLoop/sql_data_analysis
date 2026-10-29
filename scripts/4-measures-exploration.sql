-- 1.Find the total sales
SELECT SUM(sales_amount) total_sales FROM gold.fact_sales;

-- 2.Find how many items are sold
SELECT SUM(quantity) total_quanity FROM gold.fact_sales;

-- 3.Find the average selling price
SELECT AVG(price) avg_price FROM gold.fact_sales;

-- 4.Find the total number of orders
SELECT COUNT(order_number) total_orders FROM gold.fact_sales;

SELECT COUNT(DISTINCT order_number) total_orders FROM gold.fact_sales;

--5. Find the total number of products
SELECT COUNT(product_key)  total_product FROM gold.dim_products;

SELECT COUNT(DISTINCT product_key)  total_product FROM gold.dim_products;

-- 6.Find the total number of customers'
SELECT COUNT(customer_key) total_customers FROM gold.dim_customers;

-- 7.Find the total number of customers that has placed an order
SELECT COUNT( DISTINCT customer_key) total_customers FROM gold.fact_sales;

-- Generate a Report that shows all key metrics of the business
SELECT 'total_sales' AS measure_name , SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'total_quanity' , SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'avg_price'  , AVG(price)  FROM gold.fact_sales
UNION ALL
SELECT 'total_orders'  , COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'total_product' , COUNT(DISTINCT product_key)  FROM gold.dim_products
UNION ALL
SELECT 'total_customers' , COUNT(customer_key)  FROM gold.dim_customers
UNION ALL
SELECT 'total_customers_with_order' ,  COUNT(DISTINCT customer_key)  FROM gold.fact_sales




