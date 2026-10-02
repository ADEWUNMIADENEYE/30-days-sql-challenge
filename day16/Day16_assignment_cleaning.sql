SELECT*
FROM assignment_design_efficacy

--I converted all decimals toz
SELECT TOP 20
    efficacy_score,
    CAST(ROUND(efficacy_score * 100, 0) AS INT) AS efficacy_score_pct
FROM assignment_design_efficacy

--creating a backup table
SELECT * INTO assignment_design_efficacy_backup
FROM assignment_design_efficacy;

--
SELECT TOP 20
    efficacy_score,       CAST(ROUND(efficacy_score * 100, 0) AS INT)       AS efficacy_score_new,
    student_engagement,   CAST(ROUND(student_engagement * 100, 0) AS INT)   AS engagement_new,
    learning_outcome,     CAST(ROUND(learning_outcome * 100, 0) AS INT)     AS outcome_new,
    ai_detection_rate,    CAST(ROUND(ai_detection_rate * 100, 0) AS INT)    AS ai_detection_new,
    student_satisfaction, CAST(ROUND(student_satisfaction * 100, 0) AS INT) AS satisfaction_new
FROM assignment_design_efficacy;

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

---
SELECT *
FROM assignment_design_efficacy
WHERE efficacy_score       NOT BETWEEN 0 AND 100
   OR student_engagement   NOT BETWEEN 0 AND 100
   OR learning_outcome     NOT BETWEEN 0 AND 100
   OR ai_detection_rate    NOT BETWEEN 0 AND 100
   OR student_satisfaction NOT BETWEEN 0 AND 100;

UPDATE assignment_design_efficacy
SET ai_detection_rate = CASE WHEN ai_detection_rate < 0 THEN 0
                             WHEN ai_detection_rate > 100 THEN 100
                             ELSE ai_detection_rate END,
    student_satisfaction = CASE WHEN student_satisfaction < 0 THEN 0
                                WHEN student_satisfaction > 100 THEN 100
                                ELSE student_satisfaction END;

--check nulls
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

SELECT design_type, COUNT(*) AS n FROM assignment_design_efficacy GROUP BY design_type;
SELECT implementation_cost, COUNT(*) AS n FROM assignment_design_efficacy GROUP BY implementation_cost;
SELECT faculty_workload, COUNT(*) AS n FROM assignment_design_efficacy GROUP BY faculty_workload;
SELECT subject, COUNT(*) AS n FROM assignment_design_efficacy GROUP BY subject;


--checking for duplicates
SELECT design_type, efficacy_score, student_engagement, learning_outcome,
       ai_detection_rate, student_satisfaction, implementation_cost,
       faculty_workload, class_size, subject, COUNT(*) AS n
FROM assignment_design_efficacy
GROUP BY design_type, efficacy_score, student_engagement, learning_outcome,
         ai_detection_rate, student_satisfaction, implementation_cost,
         faculty_workload, class_size, subject
HAVING COUNT(*) > 1;

--
SELECT design_type, COUNT(*) AS n FROM assignment_design_efficacy GROUP BY design_type;
SELECT implementation_cost, COUNT(*) AS n FROM assignment_design_efficacy GROUP BY implementation_cost;
SELECT faculty_workload, COUNT(*) AS n FROM assignment_design_efficacy GROUP BY faculty_workload;
SELECT subject, COUNT(*) AS n FROM assignment_design_efficacy GROUP BY subject;

--
SELECT COUNT(*) AS rows_with_hidden_spaces
FROM assignment_design_efficacy
WHERE DATALENGTH(design_type)         <> DATALENGTH(LTRIM(RTRIM(design_type)))
   OR DATALENGTH(implementation_cost) <> DATALENGTH(LTRIM(RTRIM(implementation_cost)))
   OR DATALENGTH(faculty_workload)    <> DATALENGTH(LTRIM(RTRIM(faculty_workload)))
   OR DATALENGTH(subject)             <> DATALENGTH(LTRIM(RTRIM(subject)));

--
SELECT design_type, efficacy_score, student_engagement, learning_outcome,
       ai_detection_rate, student_satisfaction, implementation_cost,
       faculty_workload, class_size, subject, COUNT(*) AS n
FROM assignment_design_efficacy
GROUP BY design_type, efficacy_score, student_engagement, learning_outcome,
         ai_detection_rate, student_satisfaction, implementation_cost,
         faculty_workload, class_size, subject
HAVING COUNT(*) > 1;