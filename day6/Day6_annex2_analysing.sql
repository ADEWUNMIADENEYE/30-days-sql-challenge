-- Total revenue over time
SELECT Date, SUM(Quantity_Sold_kilo * Unit_Selling_Price_RMB_kg) AS daily_revenue
FROM annex2
WHERE Sale_or_Return = 'sale'
GROUP BY Date
ORDER BY Date;

SELECT YEAR(Date) AS yr, MONTH(Date) AS mo, 
       SUM(Quantity_Sold_kilo * Unit_Selling_Price_RMB_kg) AS monthly_revenue
FROM annex2
WHERE Sale_or_Return = 'sale'
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY yr, mo;

SELECT Sale_or_Return, COUNT(*) AS transaction_count,
       CAST(COUNT(*) AS FLOAT) / (SELECT COUNT(*) FROM annex2) AS pct_of_total
FROM annex2
GROUP BY Sale_or_Return;

SELECT Discount_Yes_No, 
       AVG(Quantity_Sold_kilo) AS avg_qty_sold,
       AVG(Unit_Selling_Price_RMB_kg) AS avg_price
FROM annex2
WHERE Sale_or_Return = 'sale'
GROUP BY Discount_Yes_No;

SELECT MIN(Unit_Selling_Price_RMB_kg) AS min_price,
       MAX(Unit_Selling_Price_RMB_kg) AS max_price,
       AVG(Unit_Selling_Price_RMB_kg) AS avg_price
FROM annex2
WHERE Sale_or_Return = 'sale';

SELECT TOP 10 Date, SUM(Quantity_Sold_kilo) AS total_qty
FROM annex2
WHERE Sale_or_Return = 'sale'
GROUP BY Date
ORDER BY total_qty DESC;

SELECT TOP 10 Item_Code, SUM(Quantity_Sold_kilo * Unit_Selling_Price_RMB_kg) AS revenue
FROM annex2
WHERE Sale_or_Return = 'sale'
GROUP BY Item_Code
ORDER BY revenue DESC;

SELECT 
    DATENAME(WEEKDAY, Date) AS day_of_week,
    COUNT(*) AS transaction_count,
    SUM(Quantity_Sold_kilo) AS total_qty_sold,
    SUM(Quantity_Sold_kilo * Unit_Selling_Price_RMB_kg) AS total_revenue,
    AVG(Unit_Selling_Price_RMB_kg) AS avg_price
FROM annex2
WHERE Sale_or_Return = 'sale'
GROUP BY DATENAME(WEEKDAY, Date)
ORDER BY total_revenue DESC;

SELECT TOP 20
    Item_Code,
    COUNT(*) AS return_count
FROM annex2
WHERE Sale_or_Return = 'return'
GROUP BY Item_Code
ORDER BY return_count DESC;

SELECT 
    YEAR(Date) AS yr, 
    MONTH(Date) AS mo,
    SUM(CASE WHEN Sale_or_Return = 'return' THEN 1 ELSE 0 END) AS returns,
    SUM(CASE WHEN Sale_or_Return = 'sale' THEN 1 ELSE 0 END) AS sales,
    CAST(SUM(CASE WHEN Sale_or_Return = 'return' THEN 1 ELSE 0 END) AS FLOAT) 
        / NULLIF(COUNT(*), 0) AS return_rate
FROM annex2
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY yr, mo;

SELECT 
    Discount_Yes_No,
    COUNT(*) AS transaction_count,
    AVG(Quantity_Sold_kilo) AS avg_qty_per_transaction,
    SUM(Quantity_Sold_kilo * Unit_Selling_Price_RMB_kg) AS total_revenue,
    AVG(Unit_Selling_Price_RMB_kg) AS avg_price
FROM annex2
WHERE Sale_or_Return = 'sale'
GROUP BY Discount_Yes_No;

SELECT 
    Discount_Yes_No,
    Sale_or_Return,
    COUNT(*) AS transaction_count
FROM annex2
GROUP BY Discount_Yes_No, Sale_or_Return
ORDER BY Discount_Yes_No, Sale_or_Return;