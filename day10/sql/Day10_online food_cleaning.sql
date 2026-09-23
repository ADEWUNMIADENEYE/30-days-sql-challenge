SELECT*
FROM online_food

--Confirming if the "column14" is the same as "output"
SELECT COUNT(*) AS mismatches
FROM online_food
WHERE Output <> column14
   OR (Output IS NULL AND column14 IS NOT NULL)
   OR (Output IS NOT NULL AND column14 IS NULL);

--Removing column14
ALTER TABLE online_food DROP COLUMN column14;


SELECT Marital_Status, COUNT(*) AS n
FROM online_food
GROUP BY Marital_Status
ORDER BY n DESC;


--Checking and counting nulls
SELECT*
FROM online_food
WHERE Age IS NULL
	OR Gender IS NULL
	OR Marital_Status IS NULL
	OR Occupation IS NULL
	OR Monthly_Income IS NULL
	OR Educational_Qualifications IS NULL
	OR Family_size IS NULL
	OR Customer_Type IS NULL
	OR latitude IS NULL
	OR longitude IS NULL
	OR Pin_code IS NULL
	OR Output IS NULL
	OR Feedback IS NULL

SELECT
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_nulls,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_nulls,
    SUM(CASE WHEN Marital_Status IS NULL THEN 1 ELSE 0 END) AS Marital_Status_nulls,
    SUM(CASE WHEN Occupation IS NULL THEN 1 ELSE 0 END) AS Occupation_nulls,
    SUM(CASE WHEN Monthly_Income IS NULL THEN 1 ELSE 0 END) AS Income_nulls,
    SUM(CASE WHEN Educational_Qualifications IS NULL THEN 1 ELSE 0 END) AS Education_nulls,
    SUM(CASE WHEN Family_size IS NULL THEN 1 ELSE 0 END) AS Family_size_nulls,
    SUM(CASE WHEN Customer_Type IS NULL THEN 1 ELSE 0 END) AS Customer_Type_nulls,
    SUM(CASE WHEN latitude IS NULL THEN 1 ELSE 0 END) AS latitude_nulls,
    SUM(CASE WHEN longitude IS NULL THEN 1 ELSE 0 END) AS longitude_nulls,
    SUM(CASE WHEN Pin_code IS NULL THEN 1 ELSE 0 END) AS Pin_code_nulls,
    SUM(CASE WHEN Output IS NULL THEN 1 ELSE 0 END) AS Output_nulls,
    SUM(CASE WHEN Feedback IS NULL THEN 1 ELSE 0 END) AS Feedback_nulls
FROM online_food;

--Checking for duplicate rows
SELECT Age, Gender, Marital_Status, Occupation, Monthly_Income,
       Educational_Qualifications, Family_size, Customer_Type,
       latitude, longitude, Pin_code, Output, Feedback,
       COUNT(*) AS times_repeated
FROM online_food
GROUP BY Age, Gender, Marital_Status, Occupation, Monthly_Income,
         Educational_Qualifications, Family_size, Customer_Type,
         latitude, longitude, Pin_code, Output, Feedback
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS duplicate_groups,
       SUM(times_repeated - 1) AS extra_rows
FROM (
    SELECT COUNT(*) AS times_repeated
    FROM online_food
    GROUP BY Age, Gender, Marital_Status, Occupation, Monthly_Income,
             Educational_Qualifications, Family_size, Customer_Type,
             latitude, longitude, Pin_code, Output, Feedback
    HAVING COUNT(*) > 1
) d;

--rows with the same location
SELECT d.Age, d.Gender, d.Occupation, d.Monthly_Income, d.Pin_code,
       d.times_repeated,
       (SELECT COUNT(*) FROM online_food o
        WHERE o.latitude = d.latitude AND o.longitude = d.longitude) AS rows_at_location
FROM (
    SELECT Age, Gender, Marital_Status, Occupation, Monthly_Income,
           Educational_Qualifications, Family_size, Customer_Type,
           latitude, longitude, Pin_code, Output, Feedback,
           COUNT(*) AS times_repeated
    FROM online_food
    GROUP BY Age, Gender, Marital_Status, Occupation, Monthly_Income,
             Educational_Qualifications, Family_size, Customer_Type,
             latitude, longitude, Pin_code, Output, Feedback
    HAVING COUNT(*) > 1
) d
ORDER BY rows_at_location;

------
WITH d AS (
    SELECT latitude, longitude,
           COUNT(*) AS times_repeated
    FROM online_food
    GROUP BY Age, Gender, Marital_Status, Occupation, Monthly_Income,
             Educational_Qualifications, Family_size, Customer_Type,
             latitude, longitude, Pin_code, Output, Feedback
    HAVING COUNT(*) > 1
)
SELECT
    SUM(CASE WHEN x.rows_at_location = d.times_repeated THEN 1 ELSE 0 END) AS likely_true_duplicates,
    SUM(CASE WHEN x.rows_at_location > d.times_repeated THEN 1 ELSE 0 END) AS location_shared_with_others,
    COUNT(*) AS total_groups
FROM d
CROSS APPLY (
    SELECT COUNT(*) AS rows_at_location
    FROM online_food o
    WHERE o.latitude = d.latitude AND o.longitude = d.longitude
) x;

--creating a table that removes only 7 likely duplicate tables
WITH ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY Age, Gender, Marital_Status, Occupation, Monthly_Income,
                         Educational_Qualifications, Family_size, Customer_Type,
                         latitude, longitude, Pin_code, Output, Feedback
            ORDER BY (SELECT NULL)) AS rn,
        COUNT(*) OVER (
            PARTITION BY Age, Gender, Marital_Status, Occupation, Monthly_Income,
                         Educational_Qualifications, Family_size, Customer_Type,
                         latitude, longitude, Pin_code, Output, Feedback) AS grp_size,
        COUNT(*) OVER (PARTITION BY latitude, longitude) AS rows_at_location
    FROM online_food
)
SELECT Age, Gender, Marital_Status, Occupation, Monthly_Income,
       Educational_Qualifications, Family_size, Customer_Type,
       latitude, longitude, Pin_code, Output, Feedback
INTO online_food_clean
FROM ranked
WHERE NOT (grp_size > 1 AND grp_size = rows_at_location AND rn > 1);



