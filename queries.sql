##Which product categories contribute the most to revenue?##

## -- Objective: Identify top revenue-generating categories

SELECT 
    product_category,
	SUM(total_revenue) AS total_revenue
FROM amazon_sales_dataset
GROUP BY product_category
ORDER BY total_revenue DESC;

##Which are the top-performing products?##

-- Objective: Identify products driving the highest revenue

SELECT 
    product_id,
    SUM(total_revenue) AS total_revenue
FROM amazon_sales_dataset
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 10;

##How do discounts impact sales and revenue?##

-- Objective: Analyze impact of discount levels on sales performance

SELECT 
    CASE 
        WHEN discount_percent < 10 THEN 'Low Discount'
        WHEN discount_percent BETWEEN 10 AND 30 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_category,
    AVG(quantity_sold) AS avg_quantity_sold,
    AVG(total_revenue) AS avg_revenue
FROM amazon_sales_dataset
GROUP BY discount_category
ORDER BY avg_quantity_sold DESC;

##Do higher-rated products perform better?##

-- Objective: Understand relationship between ratings and performance

SELECT 
    CASE 
        WHEN rating >= 4 THEN 'High Rating'
        WHEN rating BETWEEN 3 AND 3.9 THEN 'Medium Rating'
        ELSE 'Low Rating'
    END AS rating_category,
    AVG(total_revenue) AS avg_revenue,
    AVG(quantity_sold) AS avg_quantity_sold
FROM amazon_sales_dataset
GROUP BY rating_category
ORDER BY avg_revenue DESC;

##Which products show growth opportunities?##

-- Objective: Identify high-rated but low-revenue products

SELECT 
    product_id,
    AVG(rating) AS avg_rating,
    SUM(total_revenue) AS total_revenue
FROM amazon_sales_dataset
GROUP BY product_id
HAVING AVG(rating) >= 4
ORDER BY total_revenue ASC
LIMIT 10;

##Which categories perform well without heavy discounts?

-- Objective: Identify categories with strong performance and low discounts


SELECT 
    product_category,
    AVG(discount_percent) AS avg_discount,
    SUM(total_revenue) AS total_revenue,
    SUM(quantity_sold) AS total_quantity
FROM amazon_sales_dataset
GROUP BY product_category
HAVING AVG(discount_percent) < (
    SELECT AVG(discount_percent) FROM amazon_sales_dataset
)
ORDER BY total_revenue DESC;


##How does pricing affect product performance?

-- Objective: Understand relationship between price and performance

SELECT 
    CASE 
        WHEN price < 200 THEN 'Low Price'
        WHEN price BETWEEN 200 AND 500 THEN 'Medium Price'
        ELSE 'High Price'
    END AS price_category,
    AVG(quantity_sold) AS avg_quantity_sold,
    AVG(total_revenue) AS avg_revenue,
    AVG(discount_percent) AS avg_discount
FROM amazon_sales_dataset
GROUP BY price_category
ORDER BY avg_revenue DESC;

## What factors drive high-performing products?

-- Objective: Identify characteristics of top-performing products

SELECT 
    product_id,
    SUM(total_revenue) AS total_revenue,
    AVG(rating) AS avg_rating,
    AVG(discount_percent) AS avg_discount,
    SUM(quantity_sold) AS total_quantity
FROM amazon_sales_dataset
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 10;

 -- FINAL BUSINESS INSIGHTS
-- =====================================================

-- 1. Revenue is concentrated among a small number of top-performing products
-- 2. Discounts increase sales volume but are not always efficient for revenue
-- 3. Higher-rated products tend to perform better, highlighting importance of customer trust
-- 4. Some high-rated products generate low revenue, indicating growth opportunities
-- 5. Certain categories perform well even without heavy discounts, showing pricing power
-- 6. Pricing impacts both sales volume and revenue, requiring a balanced strategy
