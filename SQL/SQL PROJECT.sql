CREATE DATABASE adventure_works_project;
USE adventure_works_project;

SELECT COUNT(*) AS Total_Rows FROM sales;
SELECT * FROM sales LIMIT 10;
SELECT COUNT(*) AS Total_Rows,
COUNT(DISTINCT SalesOrderNumber) AS Total_Orders,
MIN(OrderDateKey) AS First_Order_Date,
MAX(OrderDateKey) AS Last_Order_Date FROM sales;
DESCRIBE sales;

-- Q1 --
SELECT ProductKey, `Product Name` FROM sales LIMIT 10;

-- Q2-- 
SELECT CustomerKey, `Customer Full Name`, ProductKey, `Product Unit Price`
FROM sales LIMIT 10;

-- Q3 --

-- Q3 --

SELECT
    OrderDateKey,
    Date,
    YEAR,
    Month,
    `Month Full Name`,
    Quarter,
    YearMonth,
    `Weekday No`,
    `Weekday Name`,
    `Financial Month`,
    `Financial Quarter`
FROM sales
LIMIT 10;

-- Q4 --
SELECT
    UnitPrice,
    OrderQuantity,
    UnitPriceDiscountPct,
    UnitPrice * OrderQuantity * (1 - UnitPriceDiscountPct) AS Calculated_Sales_Amount
FROM sales
LIMIT 10;

-- Q5 --

SELECT
    ProductStandardCost,
    OrderQuantity,
    ProductStandardCost * OrderQuantity AS Calculated_Production_Cost
FROM sales
LIMIT 10;

-- Q6 --
SELECT
    UnitPrice,
    OrderQuantity,
    UnitPriceDiscountPct,
    ProductStandardCost,
    UnitPrice * OrderQuantity * (1 - UnitPriceDiscountPct) 
        AS Sales_Amount,
    ProductStandardCost * OrderQuantity 
        AS Production_Cost,
    (UnitPrice * OrderQuantity * (1 - UnitPriceDiscountPct))
    - (ProductStandardCost * OrderQuantity) 
AS Profit FROM sales LIMIT 10;

-- Q7 --

SELECT
    YEAR(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS Year,
    
    MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS MonthNo,
    
    MONTHNAME(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS MonthFullName,
    
    ROUND(
        SUM(UnitPrice * OrderQuantity * (1 - UnitPriceDiscountPct)),
        2
    ) AS Total_Sales

FROM sales

WHERE YEAR(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) = 2013

GROUP BY
    YEAR(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')),
    MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')),
    MONTHNAME(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d'))

ORDER BY MonthNo;

-- Q8 --
SELECT
    YEAR(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS Year,
    ROUND(
        SUM(UnitPrice * OrderQuantity * (1 - UnitPriceDiscountPct)),
        2
    ) AS Total_Sales
FROM sales
GROUP BY
    YEAR(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d'))
ORDER BY Year;

-- Q9 --
SELECT
    MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS MonthNo,
    MONTHNAME(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS MonthFullName,
    ROUND(
        SUM(UnitPrice * OrderQuantity * (1 - UnitPriceDiscountPct)),
        2
    ) AS Total_Sales
FROM sales
GROUP BY
    MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')),
    MONTHNAME(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d'))
ORDER BY MonthNo;

-- Q10 --

SELECT
    Quarter,
    ROUND(SUM(Sales_Amount), 2) AS Total_Sales
FROM
(
    SELECT
        CONCAT(
            'Q',
            QUARTER(
                STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')
            )
        ) AS Quarter,

        UnitPrice * OrderQuantity * (1 - UnitPriceDiscountPct)
            AS Sales_Amount

    FROM sales
) AS Q10_Data

GROUP BY Quarter
ORDER BY Quarter;

-- Q11 --

SELECT
    YEAR(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS Year,

    ROUND(
        SUM(UnitPrice * OrderQuantity * (1 - UnitPriceDiscountPct)),
        2
    ) AS Total_Sales,

    ROUND(
        SUM(ProductStandardCost * OrderQuantity),
        2
    ) AS Total_Production_Cost

FROM sales

GROUP BY
    YEAR(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d'))

ORDER BY Year;

-- Q12 A - Top 10 Products by Sales

SELECT
    `Product Name`,
    ROUND(
        SUM(UnitPrice * OrderQuantity * (1 - UnitPriceDiscountPct)),
        2
    ) AS Total_Sales
FROM sales
GROUP BY `Product Name`
ORDER BY Total_Sales DESC
LIMIT 10;

-- Q12 B - Top 10 Customers by Sales

SELECT
    `Customer Full Name`,
    ROUND(
        SUM(UnitPrice * OrderQuantity * (1 - UnitPriceDiscountPct)),
        2
    ) AS Total_Sales
FROM sales
GROUP BY `Customer Full Name`
ORDER BY Total_Sales DESC
LIMIT 10;

-- Q12 C - Sales by Region

SELECT
    Region,
    ROUND(
        SUM(UnitPrice * OrderQuantity * (1 - UnitPriceDiscountPct)),
        2
    ) AS Total_Sales
FROM sales
GROUP BY Region
ORDER BY Total_Sales DESC;


















