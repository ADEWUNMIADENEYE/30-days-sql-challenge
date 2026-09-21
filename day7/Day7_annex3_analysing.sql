SELECT 
    MIN(Wholesale_Price_RMB_kg) AS min_price,
    MAX(Wholesale_Price_RMB_kg) AS max_price,
    AVG(Wholesale_Price_RMB_kg) AS avg_price
FROM annex3
WHERE Item_Code IS NOT NULL;

SELECT 
    YEAR(Date) AS yr, 
    MONTH(Date) AS mo,
    AVG(Wholesale_Price_RMB_kg) AS avg_monthly_price
FROM annex3
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY yr, mo;

SELECT 
    Item_Code,
    COUNT(*) AS price_records,
    MIN(Wholesale_Price_RMB_kg) AS min_price,
    MAX(Wholesale_Price_RMB_kg) AS max_price,
    AVG(Wholesale_Price_RMB_kg) AS avg_price,
    STDEV(Wholesale_Price_RMB_kg) AS price_stdev
FROM annex3
WHERE Item_Code IS NOT NULL
GROUP BY Item_Code
ORDER BY price_stdev DESC;

SELECT 
    Item_Code, Date, Wholesale_Price_RMB_kg,
    LAG(Wholesale_Price_RMB_kg) OVER (PARTITION BY Item_Code ORDER BY Date) AS prev_price,
    Wholesale_Price_RMB_kg - LAG(Wholesale_Price_RMB_kg) OVER (PARTITION BY Item_Code ORDER BY Date) AS price_change
FROM annex3
WHERE Item_Code IS NOT NULL
ORDER BY ABS(Wholesale_Price_RMB_kg - LAG(Wholesale_Price_RMB_kg) OVER (PARTITION BY Item_Code ORDER BY Date)) DESC;

SELECT Item_Code, COUNT(*) AS record_count
FROM annex3
WHERE Item_Code IS NOT NULL
GROUP BY Item_Code
ORDER BY record_count ASC;