# Online Food Delivery Dataset: Data Cleaning README

## Overview

This document records how the raw customer survey data was cleaned in SQL Server before analysis.

- **Database:** `Sales_Data`
- **Raw table:** `online_food` (kept untouched as the original)
- **Cleaned table:** `online_food_clean` (used for all analysis)
- **Source:** Online Food Delivery Preference survey, Bangalore, India. Each row is one customer (survey respondent), not one order.
- **Raw size:** 388 rows, 14 columns
- **Cleaned size:** 381 rows, 14 columns (13 original columns plus one added sort column)

## Column Guide

| Column | Meaning |
|---|---|
| Age | Customer age (years) |
| Gender | Male / Female |
| Marital_Status | Single / Married / Prefer not to say |
| Occupation | Student / Employee / Self Employed / House wife |
| Monthly_Income | Income band (text category) |
| Educational_Qualifications | School / Graduate / Post Graduate / Ph.D / Uneducated |
| Family_size | Number of people in the customer's family |
| Customer_Type | Frequent / Regular / New (how often they order) |
| latitude, longitude | Location coordinates (mostly shared per area, not exact addresses) |
| Pin_code | Bangalore postal code |
| Output | 1 / 0 outcome flag (stored as `bit`; shown as Yes / No in the original Excel file) |
| Feedback | Positive / Negative |
| Income_Order | Added column (0-4) so income bands sort from lowest to highest |

## Cleaning Steps

### 1. Removed a duplicate column (`column14`)

The import created an unnamed 14th column, which SQL Server named `column14`. It matched `Output` in the Excel view and in the SQL screenshots. A mismatch check confirmed it was identical to `Output` in all 388 rows:

```sql
SELECT COUNT(*) AS mismatches
FROM online_food
WHERE Output <> column14
   OR (Output IS NULL AND column14 IS NOT NULL)
   OR (Output IS NOT NULL AND column14 IS NULL);
-- Result: 0
```

The column was then dropped:

```sql
ALTER TABLE online_food DROP COLUMN column14;
```

### 2. Checked for missing values

A row-level `IS NULL` check across all 13 remaining columns found **no NULLs**. Placeholder values (such as "Prefer not to say") are not NULLs, so they were checked separately (step 3).

### 3. Reviewed the "Prefer not to say" value in Marital_Status

| Marital_Status | Rows (of 388) |
|---|---|
| Single | 268 |
| Married | 108 |
| Prefer not to say | 12 (about 3%) |

**Decision:** kept as its own category. It is a real response rather than missing data, deleting it would lose the customers' other information, and guessing a value would invent data. It can be excluded from any analysis that specifically needs marital status.

### 4. Investigated duplicate rows

Grouping on all 13 columns found **66 groups** of identical rows. Because the dataset has no customer ID or timestamp, identical rows cannot be proven to be the same person. Many respondents are young, single students with no income living in a few pin codes, and coordinates are largely shared per area, so identical rows can happen by chance.

To separate likely errors from coincidences, each group was compared with how many customers share its exact coordinates (`rows_at_location`):

- If `rows_at_location` equals the group size, the repeated rows are the **only** customers at that spot, so they are likely one person submitting more than once.
- If `rows_at_location` is larger, other customers live there too, so the matches are plausibly different people.

| Result | Groups |
|---|---|
| Likely true duplicates | 7 |
| Location shared with other customers (kept) | 59 |
| Total | 66 |

**Decision:** removed only the extra copy from the 7 likely duplicates (7 rows removed: 388 to 381). The other 59 groups were kept. A blanket `SELECT DISTINCT` table (`online_food_dedup`) was also created during the investigation, but it removes real customers from busy areas such as pin code 560009, so it was **not** used.

The cleaned table was built with:

```sql
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
```

Row count check: `SELECT COUNT(*) FROM online_food_clean;` returned **381**.

### 5. Checked data types

| Column | Type | Note |
|---|---|---|
| Age, Family_size | tinyint | Whole numbers, fine |
| latitude, longitude | float | Correct for coordinates |
| Pin_code | int | Fine (no leading zeros) |
| Output | bit | Use `CAST(Output AS FLOAT)` for averages and rates |
| All other columns | nvarchar | Categories |

No changes were needed.

### 6. Standardized and ordered Monthly_Income

The income bands were text with one inconsistent label ("Below Rs.10000") and no natural sort order. The label was made consistent and a numeric sort column was added:

```sql
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
```

Result (381 rows):

| Income_Order | Monthly_Income | Customers |
|---|---|---|
| 0 | No Income | 184 |
| 1 | Below 10000 | 24 |
| 2 | 10001 to 25000 | 44 |
| 3 | 25001 to 50000 | 68 |
| 4 | More than 50000 | 61 |

Use `ORDER BY Income_Order` when grouping by income so results read from lowest to highest.

### 7. Checked category consistency

Distinct values of the main categorical columns were listed to look for near-duplicates (for example "Male" vs "male " or "Student" vs "Students"). None were found, and each column's counts add up to 381.

| Column | Values (customers) |
|---|---|
| Customer_Type | Regular (215), Frequent (144), New (22) |
| Educational_Qualifications | Graduate (173), Post Graduate (171), Ph.D (23), School (12), Uneducated (2) |
| Feedback | Positive (312), Negative (69) |
| Gender | Male (218), Female (163) |
| Occupation | Student (203), Employee (116), Self Employed (53), House wife (9) |

## Summary of Changes

| Step | Change | Rows affected |
|---|---|---|
| 1 | Dropped duplicate column `column14` | 388 (column removed) |
| 2 | NULL check | none found |
| 3 | "Prefer not to say" kept as its own category | 0 |
| 4 | Removed 7 likely duplicate rows | 388 to 381 |
| 5 | Data type review | no changes |
| 6 | Relabelled "Below Rs.10000" and added `Income_Order` | 24 relabelled; sort column added to all rows |
| 7 | Category consistency check | no changes |

## Limitations and Notes

- **No customer ID or timestamp.** The duplicate decision is a judgement based on identical answers plus a quiet location. The 7 removed rows are "likely" duplicates, not confirmed ones.
- **Shared coordinates.** Latitude and longitude are largely assigned per area, so they identify where a customer is, not who they are.
- **Small groups.** Uneducated (2), House wife (9), School (12), New customers (22), and the Below 10000 income band (24) have few customers, so percentages for these groups are unstable. Report counts alongside percentages, or combine small categories.
- **Raw data preserved.** `online_food` is unchanged. Rebuild `online_food_clean` from it if any step needs to be revisited.
- `online_food_dedup` (blanket `SELECT DISTINCT`) is not used and can be dropped.

## Next Step

Analysis on `online_food_clean`, starting with the Output rate by income band and customer type.