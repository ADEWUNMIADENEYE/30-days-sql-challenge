# Data Cleaning README: `assignment_design_efficacy`

## Overview

| Item | Detail |
|---|---|
| Database | `Education` |
| Table | `assignment_design_efficacy` |
| Tool | SQL Server (SSMS) |
| Rows | 240 |
| Backup table | `assignment_design_efficacy_backup` (created before any changes) |

### Columns

| Column | Type after cleaning | Description |
|---|---|---|
| `design_type` | text | Assignment design (8 types, 30 rows each) |
| `efficacy_score` | INT (0-100) | Effectiveness score, stored as a percentage |
| `student_engagement` | INT (0-100) | Engagement score |
| `learning_outcome` | INT (0-100) | Learning outcome score |
| `ai_detection_rate` | INT (0-100) | AI detection rate |
| `student_satisfaction` | INT (0-100) | Satisfaction score |
| `implementation_cost` | text | Low / Medium / High |
| `faculty_workload` | text | Low / Medium / High |
| `class_size` | INT | Number of students |
| `subject` | text | Humanities / Social Sciences / STEM |

---

## Cleaning Steps

### Step 1: Back up the original table

```sql
SELECT * INTO assignment_design_efficacy_backup
FROM assignment_design_efficacy;
```

### Step 2: Convert decimals to whole numbers

The five score columns originally held decimals between 0 and 1 (for example, 0.2039). Rounding these directly would turn nearly every value into 0 or 1 and destroy the information, so each value was multiplied by 100 (converted to a percentage), rounded, and the column type changed to `INT`.

```sql
UPDATE assignment_design_efficacy
SET efficacy_score       = ROUND(efficacy_score * 100, 0),
    student_engagement   = ROUND(student_engagement * 100, 0),
    learning_outcome     = ROUND(learning_outcome * 100, 0),
    ai_detection_rate    = ROUND(ai_detection_rate * 100, 0),
    student_satisfaction = ROUND(student_satisfaction * 100, 0);

ALTER TABLE assignment_design_efficacy ALTER COLUMN efficacy_score       INT;
ALTER TABLE assignment_design_efficacy ALTER COLUMN student_engagement   INT;
ALTER TABLE assignment_design_efficacy ALTER COLUMN learning_outcome     INT;
ALTER TABLE assignment_design_efficacy ALTER COLUMN ai_detection_rate    INT;
ALTER TABLE assignment_design_efficacy ALTER COLUMN student_satisfaction INT;
```

Note: the `UPDATE` must only be run once, otherwise values are multiplied by 100 again.

### Step 3: Check for out-of-range values

All score columns are percentages, so valid values fall between 0 and 100.

```sql
SELECT *
FROM assignment_design_efficacy
WHERE efficacy_score       NOT BETWEEN 0 AND 100
   OR student_engagement   NOT BETWEEN 0 AND 100
   OR learning_outcome     NOT BETWEEN 0 AND 100
   OR ai_detection_rate    NOT BETWEEN 0 AND 100
   OR student_satisfaction NOT BETWEEN 0 AND 100;
```

**Result: 5 invalid rows found (about 2% of the data):**

| design_type | Column | Invalid value |
|---|---|---|
| Traditional | `ai_detection_rate` | -12 |
| Project-Based | `student_satisfaction` | 106 |
| Reflective (STEM, class size 45) | `student_satisfaction` | 102 |
| Reflective (STEM, class size 134) | `ai_detection_rate` | -3 |
| Peer-Review | `student_satisfaction` | 120 |

**Fix applied** *(keep the option you used and delete the other)*:

- **Option A: set invalid values to NULL.** No data is invented, and aggregate functions such as `AVG()` skip NULLs.

  ```sql
  UPDATE assignment_design_efficacy
  SET ai_detection_rate = NULL
  WHERE ai_detection_rate < 0 OR ai_detection_rate > 100;

  UPDATE assignment_design_efficacy
  SET student_satisfaction = NULL
  WHERE student_satisfaction < 0 OR student_satisfaction > 100;
  ```

- **Option B: clamp to the limits** (below 0 becomes 0, above 100 becomes 100). Keeps a value in every row but assumes the true value was at the limit.

  ```sql
  UPDATE assignment_design_efficacy
  SET ai_detection_rate = CASE WHEN ai_detection_rate < 0 THEN 0
                               WHEN ai_detection_rate > 100 THEN 100
                               ELSE ai_detection_rate END,
      student_satisfaction = CASE WHEN student_satisfaction < 0 THEN 0
                                  WHEN student_satisfaction > 100 THEN 100
                                  ELSE student_satisfaction END;
  ```

The range check was re-run afterwards and returned no rows.

### Step 4: Check for NULL values

```sql
SELECT
    SUM(CASE WHEN design_type          IS NULL THEN 1 ELSE 0 END) AS design_type_nulls,
    SUM(CASE WHEN efficacy_score       IS NULL THEN 1 ELSE 0 END) AS efficacy_nulls,
    SUM(CASE WHEN student_engagement   IS NULL THEN 1 ELSE 0 END) AS engagement_nulls,
    SUM(CASE WHEN learning_outcome     IS NULL THEN 1 ELSE 0 END) AS outcome_nulls,
    SUM(CASE WHEN ai_detection_rate    IS NULL THEN 1 ELSE 0 END) AS ai_detection_nulls,
    SUM(CASE WHEN student_satisfaction IS NULL THEN 1 ELSE 0 END) AS satisfaction_nulls,
    SUM(CASE WHEN implementation_cost  IS NULL THEN 1 ELSE 0 END) AS cost_nulls,
    SUM(CASE WHEN faculty_workload     IS NULL THEN 1 ELSE 0 END) AS workload_nulls,
    SUM(CASE WHEN class_size           IS NULL THEN 1 ELSE 0 END) AS class_size_nulls,
    SUM(CASE WHEN subject              IS NULL THEN 1 ELSE 0 END) AS subject_nulls
FROM assignment_design_efficacy;
```

**Result:** 0 NULLs in all 10 columns (checked before the out-of-range fix).

### Step 5: Check text columns for inconsistencies

```sql
SELECT design_type, COUNT(*) AS n FROM assignment_design_efficacy GROUP BY design_type;
SELECT implementation_cost, COUNT(*) AS n FROM assignment_design_efficacy GROUP BY implementation_cost;
SELECT faculty_workload, COUNT(*) AS n FROM assignment_design_efficacy GROUP BY faculty_workload;
SELECT subject, COUNT(*) AS n FROM assignment_design_efficacy GROUP BY subject;
```

**Result:** no spelling or capitalization variants.

| Column | Categories (row counts) |
|---|---|
| `design_type` | Multi-Stage, Oral Defense, Peer-Review, Process-Oriented, Project-Based, Reflective, Scaffolded, Traditional (30 each) |
| `implementation_cost` | High 71, Low 78, Medium 91 |
| `faculty_workload` | High 87, Low 87, Medium 66 |
| `subject` | Humanities 75, Social Sciences 91, STEM 74 |

### Step 6: Check for hidden leading/trailing spaces

SQL Server ignores trailing spaces when grouping, so this check catches spaces the previous step could hide.

```sql
SELECT COUNT(*) AS rows_with_hidden_spaces
FROM assignment_design_efficacy
WHERE DATALENGTH(design_type)         <> DATALENGTH(LTRIM(RTRIM(design_type)))
   OR DATALENGTH(implementation_cost) <> DATALENGTH(LTRIM(RTRIM(implementation_cost)))
   OR DATALENGTH(faculty_workload)    <> DATALENGTH(LTRIM(RTRIM(faculty_workload)))
   OR DATALENGTH(subject)             <> DATALENGTH(LTRIM(RTRIM(subject)));
```

**Result:** 0 rows.

### Step 7: Check for duplicate rows

```sql
SELECT design_type, efficacy_score, student_engagement, learning_outcome,
       ai_detection_rate, student_satisfaction, implementation_cost,
       faculty_workload, class_size, subject, COUNT(*) AS n
FROM assignment_design_efficacy
GROUP BY design_type, efficacy_score, student_engagement, learning_outcome,
         ai_detection_rate, student_satisfaction, implementation_cost,
         faculty_workload, class_size, subject
HAVING COUNT(*) > 1;
```

**Result:** no rows returned, so there are no duplicates.

---

## Summary of Changes

| Issue | Rows affected | Action |
|---|---|---|
| Scores stored as decimals (0-1) | All 240 | Converted to whole-number percentages (0-100), columns changed to `INT` |
| Out-of-range values | 5 | Handled as described in Step 3 |
| NULL values | 0 | None needed |
| Text inconsistencies / hidden spaces | 0 | None needed |
| Duplicate rows | 0 | None needed |

## Final State

- 240 rows, 10 columns, no duplicates, no inconsistent categories
- All score columns are whole numbers between 0 and 100
- Original data is preserved in `assignment_design_efficacy_backup`
- Ready for analysis