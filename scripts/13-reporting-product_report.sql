/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
===============================================================================
*/
IF OBJECT_ID('gold.product_report','V') IS NOT NULL
DROP VIEW gold.product_report;
GO
CREATE VIEW gold.product_report AS 
WITH base_query AS (
SELECT 
	    f.order_number,
        f.order_date,
		f.customer_key,
        f.sales_amount,
        f.quantity,
        p.product_key,
        p.product_name,
        p.category,
        p.subcategory,
        p.product_cost
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key=p.product_key
WHERE order_date IS NOT NULL
)
,products_aggeration AS (
    SELECT 
        product_key,
        product_name,
        category,
        subcategory,
        product_cost,
        DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) lifespan,
        MAX(order_date) last_order_date,
        COUNT( DISTINCT order_number) total_order,
        SUM(sales_amount) total_sales,
        SUM(quantity) total_quantity,
        SUM(DISTINCT customer_key) AS total_customers,
        ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)),1) AS avg_selling_price
    FROM base_query
    GROUP BY     product_key,
        product_name,
        category,
        subcategory,
        product_cost
)
SELECT 
    product_key,
    product_name,
    category,
    subcategory,
    product_cost,
    lifespan,
    last_order_date,
    DATEDIFF(MONTH,last_order_date,GETDATE()) AS recency,
    total_order,
    total_sales,
    CASE
        WHEN total_sales >50000 THEN 'High-Performers'
        WHEN total_sales  >=10000 THEN'Mid-Range'
        ELSE 'Low-Performers'
    END product_segment,
    total_quantity,
    total_customers,
    avg_selling_price,
    -- average order revenue (AOR)
    CASE
        WHEN total_sales=0 THEN 0
        ELSE total_sales/total_order
    END average_order_revenue ,
-- average monthly revenue
CASE
    WHEN lifespan=0 THEN total_sales
    ELSE total_sales/lifespan
END  average_monthly_revenue
FROM products_aggeration