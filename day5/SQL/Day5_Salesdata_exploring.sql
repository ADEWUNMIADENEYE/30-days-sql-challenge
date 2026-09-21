--Creted a new database
CREATE DATABASE Sales_Data

USE Sales_Data

--Explore the datasets
SELECT*
FROM annex1

SELECT*
FROM annex4

SELECT*
FROM annex3

SELECT*
FROM annex2




SELECT 'annex1' AS METRIC, COUNT(*) AS Total_rows FROM annex1
UNION ALL
SELECT 'annex2', COUNT(*) FROM annex2
UNION ALL
SELECT 'annex3', COUNT(*) FROM annex3
UNION ALL
SELECT 'annex4', COUNT(*) FROM annex4


