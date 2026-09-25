--Analysing sleep vs stress/occupation
SELECT 'Full' AS Version, Occupation,
       COUNT(*) AS People,
       AVG(Sleep_Duration) AS Avg_Sleep,
       AVG(CAST(Quality_of_Sleep AS FLOAT)) AS Avg_Quality,
       AVG(CAST(Stress_Level AS FLOAT)) AS Avg_Stress
FROM Sleep_health
GROUP BY Occupation
HAVING COUNT(*) >= 10
UNION ALL
SELECT 'Dedup', Occupation, COUNT(*),
       AVG(Sleep_Duration),
       AVG(CAST(Quality_of_Sleep AS FLOAT)),
       AVG(CAST(Stress_Level AS FLOAT))
FROM Sleep_health_dedup
GROUP BY Occupation
HAVING COUNT(*) >= 10
ORDER BY Occupation, Version;

SELECT Stress_Level,
       COUNT(*) AS People,
       AVG(Sleep_Duration) AS Avg_Sleep,
       AVG(CAST(Quality_of_Sleep AS FLOAT)) AS Avg_Quality
FROM Sleep_health_dedup
GROUP BY Stress_Level
ORDER BY Stress_Level;

SELECT Occupation,
       COUNT(*) AS People,
       AVG(CAST(Stress_Level AS FLOAT)) AS Avg_Stress,
       AVG(CAST(Quality_of_Sleep AS FLOAT)) AS Avg_Quality,
       AVG(Sleep_Duration) AS Avg_Sleep
FROM Sleep_health_dedup
GROUP BY Occupation
HAVING COUNT(*) >= 10
ORDER BY Avg_Stress DESC;

--looking at individual salesperson records
SELECT Person_ID, Age, Gender, Sleep_Duration, Quality_of_Sleep,
       Stress_Level, BMI_Category, Sleep_Disorder
FROM Sleep_health_dedup
WHERE Occupation = 'Salesperson'
ORDER BY Stress_Level DESC;


-- sleep disorder rate by occupation
SELECT Occupation,
       COUNT(*) AS People,
       SUM(CASE WHEN Sleep_Disorder = 'Insomnia' THEN 1 ELSE 0 END) AS Insomnia,
       SUM(CASE WHEN Sleep_Disorder = 'Sleep Apnea' THEN 1 ELSE 0 END) AS Sleep_Apnea,
       SUM(CASE WHEN Sleep_Disorder = 'None' THEN 1 ELSE 0 END) AS None_,
       CAST(100.0 * SUM(CASE WHEN Sleep_Disorder <> 'None' THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,1)) AS Pct_With_Disorder
FROM Sleep_health_dedup
GROUP BY Occupation
HAVING COUNT(*) >= 10
ORDER BY Pct_With_Disorder DESC;

--BMI distribution among nurses
SELECT Occupation, BMI_Category, COUNT(*) AS People,
       SUM(CASE WHEN Sleep_Disorder = 'Sleep Apnea' THEN 1 ELSE 0 END) AS Sleep_Apnea
FROM Sleep_health_dedup
WHERE Occupation = 'Nurse'
GROUP BY Occupation, BMI_Category
ORDER BY People DESC;

--sleep apnea rate by BMI ctegory
SELECT BMI_Category,
       COUNT(*) AS People,
       SUM(CASE WHEN Sleep_Disorder = 'Sleep Apnea' THEN 1 ELSE 0 END) AS Sleep_Apnea,
       CAST(100.0 * SUM(CASE WHEN Sleep_Disorder = 'Sleep Apnea' THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,1)) AS Pct_Sleep_Apnea
FROM Sleep_health_dedup
GROUP BY BMI_Category
ORDER BY Pct_Sleep_Apnea DESC;

--
SELECT BMI_Category, Occupation,
       COUNT(*) AS People,
       SUM(CASE WHEN Sleep_Disorder = 'Sleep Apnea' THEN 1 ELSE 0 END) AS Sleep_Apnea
FROM Sleep_health_dedup
WHERE Occupation IN ('Nurse', 'Doctor', 'Engineer', 'Accountant')
GROUP BY BMI_Category, Occupation
HAVING COUNT(*) >= 3
ORDER BY BMI_Category, Occupation;

--age pattern
SELECT
    CASE
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age < 40 THEN '30-39'
        WHEN Age < 50 THEN '40-49'
        ELSE '50+'
    END AS Age_Band,
    COUNT(*) AS People,
    AVG(Sleep_Duration) AS Avg_Sleep,
    AVG(CAST(Quality_of_Sleep AS FLOAT)) AS Avg_Quality,
    AVG(CAST(Stress_Level AS FLOAT)) AS Avg_Stress,
    AVG(CAST(Physical_Activity_Level AS FLOAT)) AS Avg_Activity,
    AVG(Daily_Steps) AS Avg_Steps
FROM Sleep_health_dedup
GROUP BY
    CASE
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age < 40 THEN '30-39'
        WHEN Age < 50 THEN '40-49'
        ELSE '50+'
    END
ORDER BY MIN(Age);

--age vs sleep disorder rate
SELECT
    CASE
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age < 40 THEN '30-39'
        WHEN Age < 50 THEN '40-49'
        ELSE '50+'
    END AS Age_Band,
    COUNT(*) AS People,
    SUM(CASE WHEN Sleep_Disorder <> 'None' THEN 1 ELSE 0 END) AS With_Disorder,
    CAST(100.0 * SUM(CASE WHEN Sleep_Disorder <> 'None' THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,1)) AS Pct_Disorder
FROM Sleep_health_dedup
GROUP BY
    CASE
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age < 40 THEN '30-39'
        WHEN Age < 50 THEN '40-49'
        ELSE '50+'
    END
ORDER BY MIN(Age);

SELECT Occupation, MIN(Age) AS Min_Age, MAX(Age) AS Max_Age, AVG(Age) AS Avg_Age
FROM Sleep_health_dedup
GROUP BY Occupation
ORDER BY Avg_Age;

--age vs stress
--doctor
SELECT
    CASE WHEN Age < 40 THEN 'Under 40' ELSE '40+' END AS Age_Group,
    COUNT(*) AS People,
    AVG(Sleep_Duration) AS Avg_Sleep,
    AVG(CAST(Quality_of_Sleep AS FLOAT)) AS Avg_Quality,
    AVG(CAST(Stress_Level AS FLOAT)) AS Avg_Stress,
    SUM(CASE WHEN Sleep_Disorder <> 'None' THEN 1 ELSE 0 END) AS With_Disorder
FROM Sleep_health_dedup
WHERE Occupation = 'Doctor'
GROUP BY CASE WHEN Age < 40 THEN 'Under 40' ELSE '40+' END;

--nurse
SELECT
    CASE WHEN Age < 40 THEN 'Under 40' ELSE '40+' END AS Age_Group,
    COUNT(*) AS People,
    AVG(Sleep_Duration) AS Avg_Sleep,
    AVG(CAST(Quality_of_Sleep AS FLOAT)) AS Avg_Quality,
    AVG(CAST(Stress_Level AS FLOAT)) AS Avg_Stress,
    SUM(CASE WHEN Sleep_Disorder <> 'None' THEN 1 ELSE 0 END) AS With_Disorder
FROM Sleep_health_dedup
WHERE Occupation = 'Nurse'
GROUP BY CASE WHEN Age < 40 THEN 'Under 40' ELSE '40+' END;

--
SELECT Gender,
       COUNT(*) AS People,
       AVG(Sleep_Duration) AS Avg_Sleep,
       AVG(CAST(Quality_of_Sleep AS FLOAT)) AS Avg_Quality,
       SUM(CASE WHEN Sleep_Disorder <> 'None' THEN 1 ELSE 0 END) AS With_Disorder,
       CAST(100.0 * SUM(CASE WHEN Sleep_Disorder <> 'None' THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,1)) AS Pct_Disorder
FROM Sleep_health_dedup
GROUP BY Gender;

SELECT
    CASE
        WHEN Physical_Activity_Level < 40 THEN 'Low (<40)'
        WHEN Physical_Activity_Level < 70 THEN 'Medium (40-69)'
        ELSE 'High (70+)'
    END AS Activity_Band,
    COUNT(*) AS People,
    AVG(Sleep_Duration) AS Avg_Sleep,
    AVG(CAST(Quality_of_Sleep AS FLOAT)) AS Avg_Quality
FROM Sleep_health_dedup
GROUP BY
    CASE
        WHEN Physical_Activity_Level < 40 THEN 'Low (<40)'
        WHEN Physical_Activity_Level < 70 THEN 'Medium (40-69)'
        ELSE 'High (70+)'
    END
ORDER BY MIN(Physical_Activity_Level);

SELECT BMI_Category,
       COUNT(*) AS People,
       AVG(Sleep_Duration) AS Avg_Sleep,
       AVG(CAST(Quality_of_Sleep AS FLOAT)) AS Avg_Quality
FROM Sleep_health_dedup
GROUP BY BMI_Category
ORDER BY Avg_Quality DESC;

SELECT BP_Category,
       COUNT(*) AS People,
       AVG(Sleep_Duration) AS Avg_Sleep,
       AVG(CAST(Quality_of_Sleep AS FLOAT)) AS Avg_Quality
FROM Sleep_health_dedup
WHERE BP_Category <> 'Elevated'
GROUP BY BP_Category
ORDER BY MIN(Systolic);