SELECT*
FROM annex3
--EXPLORING AND CLEANING THE DATA
SELECT Item_Code, COUNT(*) AS cnt
FROM annex3
GROUP BY Item_Code
HAVING COUNT(*) > 1

SELECT Date, Item_Code, Wholesale_Price_RMB_kg, COUNT(*) AS cnt
FROM annex3
GROUP BY Date, Item_Code, Wholesale_Price_RMB_kg
HAVING COUNT(*) > 1;

SELECT *
FROM annex3
WHERE Item_Code IS NULL
AND Wholesale_Price_RMB_kg IS NULL
AND Date IS NULL
ORDER BY Date, Wholesale_Price_RMB_kg;

SELECT COUNT(*) AS total_rows,
       SUM(CASE WHEN Item_Code IS NULL THEN 1 ELSE 0 END) AS null_item_code,
       SUM(CASE WHEN Item_Code IS NOT NULL THEN 1 ELSE 0 END) AS has_item_code
FROM annex3;

SELECT *
FROM annex3
WHERE Item_Code IS NOT NULL;