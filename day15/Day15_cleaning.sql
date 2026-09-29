--CREATE DATABASE Education

--USE Education

SELECT *
FROM ai_essay_submissions

SELECT TOP 20
    submission_id,
    word_count,
    ROUND(word_count, 0)            AS word_count_rounded,
    ai_probability,
    ROUND(ai_probability * 100, 0)  AS ai_probability_pct
FROM ai_essay_submissions;

--ROUNDING OFF DECIMAL NUMBERS
UPDATE ai_essay_submissions
SET ai_probability = ROUND(ai_probability * 100, 0),
    word_count     = ROUND(word_count, 0);

ALTER TABLE ai_essay_submissions ALTER COLUMN ai_probability INT;
ALTER TABLE ai_essay_submissions ALTER COLUMN word_count INT;

SELECT*
FROM ai_essay_submissions
WHERE assignment_type = 'Lab Report'

SELECT assignment_type, COUNT(*) AS cnt
FROM ai_essay_submissions
GROUP BY assignment_type
ORDER BY cnt DESC;