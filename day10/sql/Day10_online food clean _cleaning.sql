SELECT*
FROM online_food_clean
ORDER BY Age , Pin_code

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'online_food_clean';

SELECT Monthly_Income, COUNT(*) AS n
FROM online_food_clean
GROUP BY Monthly_Income
ORDER BY n DESC;

UPDATE online_food_clean
SET Monthly_Income = 'Below 10000'
WHERE Monthly_Income = 'Below Rs.10000';

ALTER TABLE online_food_clean ADD Income_Order TINYINT;

UPDATE online_food_clean
SET Income_Order = CASE Monthly_Income
    WHEN 'No Income'       THEN 0
    WHEN 'Below 10000'     THEN 1
    WHEN '10001 to 25000'  THEN 2
    WHEN '25001 to 50000'  THEN 3
    WHEN 'More than 50000' THEN 4
END;

SELECT Income_Order, Monthly_Income, COUNT(*) AS n
FROM online_food_clean
GROUP BY Income_Order, Monthly_Income
ORDER BY Income_Order;

SELECT 'Gender' AS col, Gender AS value, COUNT(*) AS n FROM online_food_clean GROUP BY Gender
UNION ALL
SELECT 'Occupation', Occupation, COUNT(*) FROM online_food_clean GROUP BY Occupation
UNION ALL
SELECT 'Education', Educational_Qualifications, COUNT(*) FROM online_food_clean GROUP BY Educational_Qualifications
UNION ALL
SELECT 'Customer_Type', Customer_Type, COUNT(*) FROM online_food_clean GROUP BY Customer_Type
UNION ALL
SELECT 'Feedback', Feedback, COUNT(*) FROM online_food_clean GROUP BY Feedback
ORDER BY col, n DESC;