SELECT*
FROM chatgpt_detection_results

--checking data type
SELECT COLUMN_NAME, DATA_TYPE, NUMERIC_PRECISION, NUMERIC_SCALE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'chatgpt_detection_results';

--creating a backup table
SELECT * INTO chatgpt_detection_results_backup
FROM chatgpt_detection_results;

--previewing the rounding up
SELECT TOP 20
    confidence_score,
    ROUND(confidence_score, 4)      AS confidence_rounded,
    ROUND(detection_probability, 4) AS detection_prob_rounded
FROM chatgpt_detection_results;

--rounding up 
ALTER TABLE chatgpt_detection_results ALTER COLUMN confidence_score      DECIMAL(6,4);
ALTER TABLE chatgpt_detection_results ALTER COLUMN writing_style_score   DECIMAL(6,4);
ALTER TABLE chatgpt_detection_results ALTER COLUMN perplexity_score      DECIMAL(6,4);
ALTER TABLE chatgpt_detection_results ALTER COLUMN detection_probability DECIMAL(6,4);

--verify
SELECT COLUMN_NAME, DATA_TYPE, NUMERIC_PRECISION, NUMERIC_SCALE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'chatgpt_detection_results'
  AND COLUMN_NAME IN ('confidence_score','writing_style_score','perplexity_score','detection_probability');

SELECT TOP 10 confidence_score, writing_style_score, perplexity_score, detection_probability
FROM chatgpt_detection_results;

--checking for duplicates
SELECT submission_id, COUNT(*) AS cnt
FROM chatgpt_detection_results
GROUP BY submission_id
HAVING COUNT(*) > 1;

--checking for nulls
SELECT
    SUM(CASE WHEN submission_id        IS NULL THEN 1 ELSE 0 END) AS null_id,
    SUM(CASE WHEN tool                 IS NULL THEN 1 ELSE 0 END) AS null_tool,
    SUM(CASE WHEN actual_type          IS NULL THEN 1 ELSE 0 END) AS null_actual_type,
    SUM(CASE WHEN detected_as_ai       IS NULL THEN 1 ELSE 0 END) AS null_detected,
    SUM(CASE WHEN confidence_score     IS NULL THEN 1 ELSE 0 END) AS null_confidence,
    SUM(CASE WHEN text_length          IS NULL THEN 1 ELSE 0 END) AS null_length,
    SUM(CASE WHEN subject              IS NULL THEN 1 ELSE 0 END) AS null_subject,
    SUM(CASE WHEN grade_level          IS NULL THEN 1 ELSE 0 END) AS null_grade,
    SUM(CASE WHEN writing_style_score  IS NULL THEN 1 ELSE 0 END) AS null_style,
    SUM(CASE WHEN perplexity_score     IS NULL THEN 1 ELSE 0 END) AS null_perplexity,
    SUM(CASE WHEN detection_probability IS NULL THEN 1 ELSE 0 END) AS null_prob
FROM chatgpt_detection_results;

SELECT *
FROM chatgpt_detection_results
WHERE writing_style_score IS NULL;

--updating the nulls
UPDATE chatgpt_detection_results
SET writing_style_score = (
    SELECT CAST(AVG(writing_style_score) AS DECIMAL(6,4))
    FROM chatgpt_detection_results
    WHERE writing_style_score IS NOT NULL
)
WHERE writing_style_score IS NULL;




--checking inconsistent categories
SELECT tool, COUNT(*) AS cnt FROM chatgpt_detection_results GROUP BY tool ORDER BY tool;
SELECT actual_type, COUNT(*) AS cnt FROM chatgpt_detection_results GROUP BY actual_type;
SELECT subject, COUNT(*) AS cnt FROM chatgpt_detection_results GROUP BY subject ORDER BY subject;
SELECT grade_level, COUNT(*) AS cnt FROM chatgpt_detection_results GROUP BY grade_level;

--checking out of range values
SELECT MIN(confidence_score) AS min_conf, MAX(confidence_score) AS max_conf,
       MIN(writing_style_score) AS min_style, MAX(writing_style_score) AS max_style,
       MIN(perplexity_score) AS min_perp, MAX(perplexity_score) AS max_perp,
       MIN(detection_probability) AS min_prob, MAX(detection_probability) AS max_prob,
       MIN(text_length) AS min_len, MAX(text_length) AS max_len
FROM chatgpt_detection_results;

SELECT
    SUM(CASE WHEN writing_style_score > 1 THEN 1 ELSE 0 END) AS style_above_1,
    SUM(CASE WHEN writing_style_score < 0 THEN 1 ELSE 0 END) AS style_below_0,
    SUM(CASE WHEN perplexity_score < 0 THEN 1 ELSE 0 END)    AS perp_below_0,
    SUM(CASE WHEN perplexity_score > 1 THEN 1 ELSE 0 END)    AS perp_above_1
FROM chatgpt_detection_results;

--
UPDATE chatgpt_detection_results
SET subject = CASE subject
    WHEN 'BIO'   THEN 'Biology'
    WHEN 'CHEM'  THEN 'Chemistry'
    WHEN 'CS'    THEN 'Computer Science'
    WHEN 'ENG'   THEN 'English'
    WHEN 'HIST'  THEN 'History'
    WHEN 'MATH'  THEN 'Mathematics'
    WHEN 'PHYS'  THEN 'Physics'
    WHEN 'PSYCH' THEN 'Psychology'
END;


SELECT MIN(writing_style_score) AS min_style, MAX(writing_style_score) AS max_style,
       MIN(perplexity_score)    AS min_perp,  MAX(perplexity_score)    AS max_perp
FROM chatgpt_detection_results;

UPDATE chatgpt_detection_results
SET writing_style_score = 1
WHERE writing_style_score > 1;

UPDATE chatgpt_detection_results
SET perplexity_score = 0
WHERE perplexity_score < 0;

SELECT MIN(writing_style_score) AS min_style, MAX(writing_style_score) AS max_style,
       MIN(perplexity_score)    AS min_perp,  MAX(perplexity_score)    AS max_perp
FROM chatgpt_detection_results;

SELECT
    tool,
    COUNT(*) AS total_checked,
    CAST(100.0 * SUM(CASE WHEN (actual_type = 'ai_generated' AND detected_as_ai = 1)
                           OR  (actual_type = 'human_written' AND detected_as_ai = 0)
                          THEN 1 ELSE 0 END)
         / SUM(CASE WHEN actual_type IN ('ai_generated','human_written') THEN 1 ELSE 0 END)
         AS DECIMAL(5,2)) AS accuracy_pct,
    CAST(100.0 * SUM(CASE WHEN actual_type = 'human_written' AND detected_as_ai = 1 THEN 1 ELSE 0 END)
         / NULLIF(SUM(CASE WHEN actual_type = 'human_written' THEN 1 ELSE 0 END), 0)
         AS DECIMAL(5,2)) AS false_positive_rate_pct,
    CAST(100.0 * SUM(CASE WHEN actual_type = 'ai_generated' AND detected_as_ai = 0 THEN 1 ELSE 0 END)
         / NULLIF(SUM(CASE WHEN actual_type = 'ai_generated' THEN 1 ELSE 0 END), 0)
         AS DECIMAL(5,2)) AS false_negative_rate_pct
FROM chatgpt_detection_results
GROUP BY tool
ORDER BY accuracy_pct DESC;

SELECT
    subject,
    COUNT(*) AS total,
    CAST(100.0 * SUM(CASE WHEN detected_as_ai = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS flagged_as_ai_pct,
    CAST(AVG(detection_probability) AS DECIMAL(6,4)) AS avg_detection_probability
FROM chatgpt_detection_results
GROUP BY subject
ORDER BY flagged_as_ai_pct DESC;

SELECT
    grade_level,
    COUNT(*) AS total,
    CAST(100.0 * SUM(CASE WHEN detected_as_ai = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS flagged_as_ai_pct,
    CAST(AVG(detection_probability) AS DECIMAL(6,4)) AS avg_detection_probability
FROM chatgpt_detection_results
GROUP BY grade_level
ORDER BY CASE grade_level
    WHEN 'Freshman' THEN 1 WHEN 'Sophomore' THEN 2 WHEN 'Junior' THEN 3
    WHEN 'Senior' THEN 4 WHEN 'Graduate' THEN 5 END;

SELECT
    tool,
    actual_type,
    COUNT(*) AS total,
    CAST(100.0 * SUM(CASE WHEN detected_as_ai = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS flagged_as_ai_pct
FROM chatgpt_detection_results
GROUP BY tool, actual_type
ORDER BY tool, actual_type;