-- ====================================================================
-- Project: Amazon E-Commerce Sales & Revenue Analytics
-- Author: Deepika Bhadri
-- Database: SQLite / MySQL / PostgreSQL
-- ====================================================================

-- --------------------------------------------------------------------
-- 1. Dataset Overview & Key Financial Metrics
-- Business Question: What is our total revenue, order count, and average order value?
-- --------------------------------------------------------------------
SELECT 
    COUNT(*) AS total_sales_records,
    ROUND(SUM(Amount), 2) AS total_revenue,
    ROUND(AVG(Amount), 2) AS avg_order_value,
    SUM(Qty) AS total_units_sold
FROM AmazonSaleReport
WHERE Amount IS NOT NULL;


-- --------------------------------------------------------------------
-- 2. Top-Selling Product Categories by Quantity and Revenue
-- Business Question: Which product categories drive the highest volume and sales?
-- --------------------------------------------------------------------
SELECT 
    Category,
    COUNT(DISTINCT "Order ID") AS unique_orders,
    SUM(Qty) AS total_quantity_sold,
    ROUND(SUM(Amount), 2) AS total_revenue,
    ROUND(AVG(Amount), 2) AS avg_price_per_sale
FROM AmazonSaleReport
WHERE Category IS NOT NULL
GROUP BY Category
ORDER BY total_quantity_sold DESC;


-- --------------------------------------------------------------------
-- 3. Top 5 Best-Selling Product SKUs
-- Business Question: What are our top 5 individual stock keeping units by sales volume?
-- --------------------------------------------------------------------
SELECT 
    SKU,
    Category,
    SUM(Qty) AS total_units_sold,
    ROUND(SUM(Amount), 2) AS total_sku_revenue
FROM AmazonSaleReport
GROUP BY SKU, Category
ORDER BY total_units_sold DESC
LIMIT 5;


-- --------------------------------------------------------------------
-- 4. Sales Distribution by Product Size
-- Business Question: Which clothing/product sizes have the highest demand?
-- --------------------------------------------------------------------
SELECT 
    Size,
    COUNT("Order ID") AS order_count,
    SUM(Qty) AS total_quantity_sold,
    ROUND(SUM(Amount), 2) AS total_size_revenue
FROM AmazonSaleReport
WHERE Size IS NOT NULL
GROUP BY Size
ORDER BY total_quantity_sold DESC;


-- --------------------------------------------------------------------
-- 5. B2B vs. Retail (B2C) Transaction Breakdown
-- Business Question: How do business orders compare to retail consumer orders?
-- --------------------------------------------------------------------
SELECT 
    CASE 
        WHEN B2B = 'true' OR B2B = 'True' THEN 'B2B Wholesale Sales'
        ELSE 'B2C Retail Sales'
    END AS customer_segment,
    COUNT("Order ID") AS total_orders,
    SUM(Qty) AS total_quantity,
    ROUND(SUM(Amount), 2) AS total_revenue,
    ROUND(AVG(Amount), 2) AS avg_transaction_value
FROM AmazonSaleReport
GROUP BY 1;


-- --------------------------------------------------------------------
-- 6. Fulfillment Method & Courier Delivery Analysis
-- Business Question: How are orders fulfilled and what is the distribution?
-- --------------------------------------------------------------------
SELECT 
    Fulfilment,
    "Courier Status" AS delivery_status,
    COUNT("Order ID") AS total_orders,
    ROUND(SUM(Amount), 2) AS total_fulfilled_revenue
FROM AmazonSaleReport
WHERE Fulfilment IS NOT NULL
GROUP BY Fulfilment, "Courier Status"
ORDER BY total_orders DESC;