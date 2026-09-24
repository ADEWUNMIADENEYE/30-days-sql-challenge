# DAY 12

# Sleep Health and Lifestyle: SQL Data Cleaning

Data cleaning and preparation of a sleep health and lifestyle dataset using **SQL Server (SSMS)**.

## Overview

| Item | Detail |
|---|---|
| Database | `HEALTH` |
| Main table | `Sleep_health` (374 rows, 13 original columns) |
| Deduplicated table | `Sleep_health_dedup` (132 rows) |
| Tool | SQL Server Management Studio |
| Source | _Add the dataset source here (e.g. Kaggle or course link)_ |

## Dataset Columns

| Column | Type (after cleaning) | Description |
|---|---|---|
| Person_ID | smallint | Row identifier |
| Gender | nvarchar(50) | Male / Female |
| Age | tinyint | Age in years |
| Occupation | nvarchar(50) | Job category |
| Sleep_Duration | decimal(3,1) | Hours of sleep per night |
| Quality_of_Sleep | tinyint | Sleep quality score |
| Physical_Activity_Level | tinyint | Physical activity score |
| Stress_Level | tinyint | Stress score |
| BMI_Category | nvarchar(50) | Normal / Overweight / Obese |
| Blood_Pressure | nvarchar(50) | Original text value (e.g. `130/85`), kept for reference |
| Heart_Rate | tinyint | Resting heart rate |
| Daily_Steps | smallint | Steps per day |
| Sleep_Disorder | nvarchar(50) | None / Insomnia / Sleep Apnea |
| **Systolic** | tinyint | _Added_: parsed from Blood_Pressure |
| **Diastolic** | tinyint | _Added_: parsed from Blood_Pressure |
| **BP_Category** | nvarchar(20) | _Added_: Normal / Elevated / Stage 1 / Stage 2 |

## Cleaning Steps

### 1. Inspect column types
```sql
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH,
       NUMERIC_PRECISION, NUMERIC_SCALE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Sleep_health'
ORDER BY ORDINAL_POSITION;
```
All columns are `NOT NULL`. No NULL handling was needed.

### 2. Fix Sleep_Duration data type
`Sleep_Duration` was stored as `FLOAT`, producing values like `7.19999980926514`. It was converted to `DECIMAL(3,1)`.
```sql
ALTER TABLE Sleep_health
ALTER COLUMN Sleep_Duration DECIMAL(3,1) NOT NULL;
```

### 3. Standardize BMI_Category
`Normal Weight` (21 rows) and `Normal` meant the same thing.
```sql
UPDATE Sleep_health
SET BMI_Category = 'Normal'
WHERE BMI_Category = 'Normal Weight';
```
Result: Normal (216), Overweight (148), Obese (10).

### 4. Standardize Occupation
`Sales Representative` (2 rows) was merged into `Salesperson`.
```sql
UPDATE Sleep_health
SET Occupation = 'Salesperson'
WHERE Occupation = 'Sales Representative';
```

### 5. Split Blood_Pressure
```sql
ALTER TABLE Sleep_health ADD Systolic TINYINT, Diastolic TINYINT;
GO

UPDATE Sleep_health
SET Systolic  = CAST(LEFT(Blood_Pressure, CHARINDEX('/', Blood_Pressure) - 1) AS TINYINT),
    Diastolic = CAST(SUBSTRING(Blood_Pressure, CHARINDEX('/', Blood_Pressure) + 1, 10) AS TINYINT);
```
Validation: 374 rows updated, 0 NULLs, systolic 115-142, diastolic 75-95.

### 6. Create BP_Category
Categories follow common AHA cutoffs and are for analysis grouping only, not a clinical diagnosis. The highest category is checked first so that a reading like `135/90` is correctly labelled Stage 2.
```sql
ALTER TABLE Sleep_health ADD BP_Category NVARCHAR(20);
GO

UPDATE Sleep_health
SET BP_Category = CASE
    WHEN Systolic >= 140 OR Diastolic >= 90 THEN 'Stage 2'
    WHEN Systolic >= 130 OR Diastolic >= 80 THEN 'Stage 1'
    WHEN Systolic >= 120                    THEN 'Elevated'
    ELSE 'Normal'
END;
```

| BP_Category | Full (374) | Dedup (132) |
|---|---|---|
| Normal | 41 | 15 |
| Elevated | 1 | 1 |
| Stage 1 | 232 | 83 |
| Stage 2 | 100 | 33 |

### 7. Handle duplicates
Rows identical in every column except `Person_ID` were counted:

- 78 duplicate groups
- 320 rows involved (about 86% of the table)
- 242 extra rows

Since it can't be confirmed whether these are genuine separate records or copies, the original table was **left untouched** and a deduplicated copy was created:
```sql
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

ALTER TABLE Sleep_health_dedup DROP COLUMN rn;
```
Analysis can be run on both tables and the results compared.

## Data Quality Notes

- **Heavy duplication.** Most rows belong to a duplicate group, which suggests the data may be templated or synthetic. Averages on the full table are dominated by repeated profiles.
- **Conflicting Sleep_Disorder labels.** In `Sleep_health_dedup`, 22 profiles have identical measurements but different `Sleep_Disorder` values. These rows were **not removed**, since the correct label can't be determined. Conclusions about sleep disorder should be treated with caution.
- **Small groups.** Scientist (4), Software Engineer (4), and Manager (1) are too small for reliable averages. Use `HAVING COUNT(*) >= 10` when comparing occupations.
- **Elevated BP category** has only one row in both tables, so it is too small to analyze on its own.
- `BP_Category` is a grouping for analysis, not medical advice.

## Example Analysis Query

Compare sleep and stress by occupation on both tables:
```sql
SELECT 'Full' AS Version, Occupation,
       COUNT(*) AS People,
       AVG(Sleep_Duration) AS Avg_Sleep,
       AVG(CAST(Stress_Level AS FLOAT)) AS Avg_Stress,
       AVG(CAST(Quality_of_Sleep AS FLOAT)) AS Avg_Quality
FROM Sleep_health
GROUP BY Occupation
HAVING COUNT(*) >= 10
UNION ALL
SELECT 'Dedup', Occupation, COUNT(*),
       AVG(Sleep_Duration),
       AVG(CAST(Stress_Level AS FLOAT)),
       AVG(CAST(Quality_of_Sleep AS FLOAT))
FROM Sleep_health_dedup
GROUP BY Occupation
HAVING COUNT(*) >= 10
ORDER BY Occupation, Version;
```

## Summary of Cleaning Decisions

| Issue | Action |
|---|---|
| Sleep_Duration stored as FLOAT | Converted to DECIMAL(3,1) |
| BMI label variants | `Normal Weight` merged into `Normal` |
| Occupation label variants | `Sales Representative` merged into `Salesperson` |
| Blood_Pressure stored as text | Split into Systolic and Diastolic |
| No BP grouping | Added BP_Category (AHA-style cutoffs) |
| Duplicate content | Kept original, created `Sleep_health_dedup` |
| Conflicting disorder labels | Kept, documented as a limitation |