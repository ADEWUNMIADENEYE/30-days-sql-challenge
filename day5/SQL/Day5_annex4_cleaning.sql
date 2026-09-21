SELECT*
FROM annex4

--EXPLORING AND CLEANING THE DATA
SELECT 
    SUM(CASE WHEN Item_Code IS NULL THEN 1 ELSE 0 END) AS null_item_code,
    SUM(CASE WHEN Item_Name IS NULL THEN 1 ELSE 0 END) AS null_item_name,
    SUM(CASE WHEN Loss_Rate IS NULL THEN 1 ELSE 0 END) AS null_loss_rate,
    COUNT(*) AS total_rows
FROM annex4;

SELECT Item_Code, COUNT(*) AS cnt
FROM annex4
GROUP BY Item_Code
HAVING COUNT(*) > 1

ALTER TABLE annex4
ADD CONSTRAINT PK_annex4 PRIMARY KEY (Item_Code)
