SELECT*
FROM Sleep_health

--Checking the column type
SELECT COLUMN_NAME,
       DATA_TYPE,
       CHARACTER_MAXIMUM_LENGTH,
       NUMERIC_PRECISION,
       NUMERIC_SCALE,
       IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Sleep_health'
ORDER BY ORDINAL_POSITION;


--changing bmi category from Normal weight to normal
UPDATE Sleep_health
SET BMI_Category = 'Normal'
WHERE BMI_Category = 'Normal Weight'

--CheckinGg if the previous query worked
SELECT BMI_Category, COUNT(*) AS Total
FROM Sleep_health
GROUP BY BMI_Category
ORDER BY Total DESC;

SELECT DISTINCT Gender FROM Sleep_health;
SELECT DISTINCT Occupation FROM Sleep_health ORDER BY Occupation;
SELECT DISTINCT Sleep_Disorder FROM Sleep_health;

--checking sleep duration
SELECT DISTINCT Sleep_Duration,
       CAST(Sleep_Duration AS DECIMAL(3,1)) AS Cleaned
FROM Sleep_health
ORDER BY Sleep_Duration;


--changing column type for sleep duration
ALTER TABLE Sleep_health
ALTER COLUMN Sleep_Duration DECIMAL(3,1) NOT NULL;

--Checking if the previous query worked
SELECT DISTINCT Sleep_Duration
FROM Sleep_health
ORDER BY Sleep_Duration;

--Splitting blood pressure into two columns
ALTER TABLE Sleep_health ADD Systolic TINYINT, Diastolic TINYINT;
GO

UPDATE Sleep_health
SET Systolic  = CAST(LEFT(Blood_Pressure, CHARINDEX('/', Blood_Pressure) - 1) AS TINYINT),
    Diastolic = CAST(SUBSTRING(Blood_Pressure, CHARINDEX('/', Blood_Pressure) + 1, 10) AS TINYINT);

SELECT MIN(Systolic) AS MinSys, MAX(Systolic) AS MaxSys,
       MIN(Diastolic) AS MinDia, MAX(Diastolic) AS MaxDia
FROM Sleep_health;

--Confirming if thre are any nulls
SELECT COUNT(*) AS NullRows
FROM Sleep_health
WHERE Systolic IS NULL OR Diastolic IS NULL;


--Checking for duplicates ignoring person_id
SELECT Gender, Age, Occupation, Sleep_Duration, Quality_of_Sleep,
       Physical_Activity_Level, Stress_Level, BMI_Category,
       Blood_Pressure, Heart_Rate, Daily_Steps, Sleep_Disorder,
       COUNT(*) AS Copies
FROM Sleep_health
GROUP BY Gender, Age, Occupation, Sleep_Duration, Quality_of_Sleep,
         Physical_Activity_Level, Stress_Level, BMI_Category,
         Blood_Pressure, Heart_Rate, Daily_Steps, Sleep_Disorder
HAVING COUNT(*) > 1
ORDER BY Copies DESC;

--checking occupation
SELECT Occupation, COUNT(*) AS Total
FROM Sleep_health
GROUP BY Occupation
ORDER BY Total DESC;

--changing 'sales representative' to 'salesperson'
UPDATE Sleep_health
SET Occupation = 'Salesperson'
WHERE Occupation = 'Sales Representative';

--creating blood pressure category
ALTER TABLE Sleep_health ADD BP_Category NVARCHAR(20);
GO

UPDATE Sleep_health
SET BP_Category = CASE
    WHEN Systolic < 120 AND Diastolic < 80 THEN 'Normal'
    WHEN Systolic < 130 AND Diastolic < 80 THEN 'Elevated'
    WHEN Systolic < 140 OR Diastolic < 90  THEN 'Stage 1'
    ELSE 'Stage 2'
END;


--
UPDATE Sleep_health
SET BP_Category = CASE
    WHEN Systolic >= 140 OR Diastolic >= 90 THEN 'Stage 2'
    WHEN Systolic >= 130 OR Diastolic >= 80 THEN 'Stage 1'
    WHEN Systolic >= 120                    THEN 'Elevated'
    ELSE 'Normal'
END;

--checking for duplicates
WITH Dups AS (
    SELECT COUNT(*) AS Copies
    FROM Sleep_health
    GROUP BY Gender, Age, Occupation, Sleep_Duration, Quality_of_Sleep,
             Physical_Activity_Level, Stress_Level, BMI_Category,
             Blood_Pressure, Heart_Rate, Daily_Steps, Sleep_Disorder
    HAVING COUNT(*) > 1
)
SELECT COUNT(*)                AS DuplicateGroups,
       SUM(Copies)             AS RowsInvolved,
       SUM(Copies - 1)         AS ExtraRows
FROM Dups;

--creating a copy 
SELECT *
INTO Sleep_health_dedup
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY Gender, Age, Occupation, Sleep_Duration, Quality_of_Sleep,
                            Physical_Activity_Level, Stress_Level, BMI_Category,
                            Blood_Pressure, Heart_Rate, Daily_Steps, Sleep_Disorder
               ORDER BY Person_ID) AS rn
    FROM Sleep_health
) t
WHERE rn = 1;