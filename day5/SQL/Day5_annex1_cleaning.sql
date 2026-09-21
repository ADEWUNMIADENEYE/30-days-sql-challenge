SELECT*
FROM annex1

--EXPLORING AND CLEANING THE DATA
SELECT 
    SUM(CASE WHEN Item_Code IS NULL THEN 1 ELSE 0 END) AS null_item_code,
    SUM(CASE WHEN Item_Name IS NULL THEN 1 ELSE 0 END) AS null_item_name,
    SUM(CASE WHEN Category_Code IS NULL THEN 1 ELSE 0 END) AS null_category_code,
    SUM(CASE WHEN Category_Name IS NULL THEN 1 ELSE 0 END) AS null_category_name,
    COUNT(*) AS total_rows
FROM annex1;

SELECT Item_Code, COUNT(*) AS cnt
FROM annex1
GROUP BY Item_Code
HAVING COUNT(*) > 1;

--MAKING "ITEM_CODE" THE PRIMRY KEY
ALTER TABLE annex1
ADD CONSTRAINT PK_annex1 PRIMARY KEY (Item_Code);
