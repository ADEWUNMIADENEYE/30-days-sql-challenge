SELECT * FROM Sleep_health_dedup;
SELECT COUNT(*) AS Total FROM Sleep_health_dedup;

--updating bp category
UPDATE Sleep_health_dedup
SET BP_Category = CASE
    WHEN Systolic >= 140 OR Diastolic >= 90 THEN 'Stage 2'
    WHEN Systolic >= 130 OR Diastolic >= 80 THEN 'Stage 1'
    WHEN Systolic >= 120                    THEN 'Elevated'
    ELSE 'Normal'
END;

--dropping rn column
ALTER TABLE Sleep_health_dedup DROP COLUMN rn;

SELECT COUNT(*) AS ProfilesWithConflictingDisorder
FROM (
    SELECT Gender, Age, Occupation, Sleep_Duration, Quality_of_Sleep,
           Physical_Activity_Level, Stress_Level, BMI_Category,
           Blood_Pressure, Heart_Rate, Daily_Steps
    FROM Sleep_health_dedup
    GROUP BY Gender, Age, Occupation, Sleep_Duration, Quality_of_Sleep,
             Physical_Activity_Level, Stress_Level, BMI_Category,
             Blood_Pressure, Heart_Rate, Daily_Steps
    HAVING COUNT(DISTINCT Sleep_Disorder) > 1
) x;


SELECT BP_Category, COUNT(*) AS Total,
       MIN(Systolic) AS MinSys, MAX(Systolic) AS MaxSys,
       MIN(Diastolic) AS MinDia, MAX(Diastolic) AS MaxDia
FROM Sleep_health_dedup
GROUP BY BP_Category
ORDER BY MinSys;

SELECT 'Full' AS Version, BP_Category, COUNT(*) AS Total,
       MIN(Systolic) AS MinSys, MAX(Systolic) AS MaxSys,
       MIN(Diastolic) AS MinDia, MAX(Diastolic) AS MaxDia
FROM Sleep_health
GROUP BY BP_Category
UNION ALL
SELECT 'Dedup', BP_Category, COUNT(*),
       MIN(Systolic), MAX(Systolic), MIN(Diastolic), MAX(Diastolic)
FROM Sleep_health_dedup
GROUP BY BP_Category
ORDER BY Version, MinSys;