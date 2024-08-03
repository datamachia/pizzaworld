-- KPI Requirements

-- 1) Total Revenue
SELECT 
	SUM(total_price) AS Total_Revenue
FROM pizza_sales;

-- 2) Average Order Value
SELECT 
	SUM(total_price) / COUNT(DISTINCT order_id) AS Average_Order_Value
FROM pizza_sales;

-- 3) Total Pizzas Sold 
SELECT 
	SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales;

-- 4) Total Orders
SELECT 
	COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;

-- 5) Average Pizzas Per Order
SELECT 
	CAST(CAST(SUM(quantity) AS DECIMAL (10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL (10,2)) AS DECIMAL (10,2)) AS Average_Pizzas_Per_Order
FROM pizza_sales;

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- Chart Requirements

-- 1) Daily Trend for Total Orders
SELECT 
	DATENAME(DW, order_date) AS Order_Day, 
	COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)
ORDER BY Total_Orders DESC;

-- 2) Monthly Trend for Total Orderds
SELECT 
	DATENAME(MONTH, order_date) AS Month_Name, 
	COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders DESC;

-- 3) Percentage of Sales by Pizza Category
SELECT
	pizza_category, 
	CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category
ORDER BY PCT DESC;

-- 4) Percentage of Sales by Pizza Size
SELECT
	pizza_size, 
	CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC;

-- 5) Total Pizzas Sold by Pizza Category
SELECT
	pizza_category, 
	SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;


-- 6) Top 5 Pizzas by Revenue
SELECT 
	Top 5 pizza_name, 
	CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

-- 7) Bottom 5 Pizzas by Revenue
SELECT 
	Top 5 pizza_name, 
	CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue;

-- 8) Top 5 Pizzas by Quantity
SELECT 
	TOP 5 pizza_name, 
	SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC;

-- 9) Bottom 5 Pizzas by Quantity
SELECT 
	TOP 5 pizza_name, 
	SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold;

-- 10) Top 5 Pizzas by Total Orders
SELECT 
	TOP 5 pizza_name, 
	COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;

-- 11) Bottom 5 Pizzas by Total Orders
SELECT 
	TOP 5 pizza_name, 
	COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders;

-- 12) Time of the day with more orders
WITH CTE AS (
    SELECT
        order_time,
        CASE
            WHEN DATEPART(HOUR, order_time) >= 6 AND DATEPART(HOUR, order_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, order_time) >= 12 AND DATEPART(HOUR, order_time) < 18 THEN 'Afternoon'
            WHEN DATEPART(HOUR, order_time) >= 18 OR DATEPART(HOUR, order_time) < 6 THEN 'Evening'
            ELSE 'Unknown'
        END AS TimeOfDay
    FROM pizza_sales
)
SELECT
    TimeOfDay,
    COUNT(*) AS OrderCount
FROM CTE
GROUP BY TimeOfDay
ORDER BY OrderCount DESC;

-- 12) Day of the week with more orders
SELECT
    DATENAME(WEEKDAY, CAST(order_time AS DATETIME)) AS DayOfWeek,
    COUNT(*) AS OrderCount
FROM pizza_sales
GROUP BY DATENAME(WEEKDAY, CAST(order_time AS DATETIME))
ORDER BY OrderCount DESC;







