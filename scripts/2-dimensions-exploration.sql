-- 2.Dimensions Exploration

-- Explore all countries our customers come from
SELECT DISTINCT country
FROM gold.dim_customers;

--Explore all products categories the major divisions
SELECT 
	DISTINCT category
FROM gold.dim_products;

-- Retrieve a list of unique categories, subcategories, and products
SELECT 
	DISTINCT category,
	subcategory,
	product_name
FROM gold.dim_products
ORDER BY category,subcategory,product_name;