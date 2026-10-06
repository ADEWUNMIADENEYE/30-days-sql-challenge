# DAY 18

# AI Detection Tools: SQL Data Cleaning & Analysis

Cleaning and exploratory analysis of an AI-text detection dataset in **SQL Server (SSMS)**, prepared for a dashboard comparing how well five AI detectors tell human-written, AI-generated and mixed text apart.

## Project Overview

- **Database:** `Education`
- **Table:** `chatgpt_detection_results`
- **Rows:** 5,000
- **Tools compared:** Copyleaks, GPTZero, Originality.ai, Turnitin, Winston AI
- **Goal:** Clean the data, then measure each detector's accuracy, false positive rate and false negative rate, and see how detection varies by subject and grade level.

## Dataset Columns

| Column | Description |
|---|---|
| `submission_id` | Unique ID for each submission |
| `tool` | AI detector used |
| `actual_type` | True nature of the text: `human_written`, `ai_generated` or `mixed` |
| `detected_as_ai` | Detector verdict (1 = flagged as AI, 0 = not flagged) |
| `confidence_score` | Detector confidence score |
| `text_length` | Length of the text (500 to 4,999) |
| `subject` | Academic subject (full names after cleaning) |
| `grade_level` | Freshman, Sophomore, Junior, Senior or Graduate |
| `writing_style_score` | Writing style score (0 to 1) |
| `perplexity_score` | Perplexity score (0 to 1) |
| `detection_probability` | Probability the text is AI-generated |

## Data Cleaning Steps

| Step | Issue found | Action |
|---|---|---|
| 1 | Score columns stored as `float(53)` with very long decimals | Converted `confidence_score`, `writing_style_score`, `perplexity_score` and `detection_probability` to `DECIMAL(6,4)` |
| 2 | Duplicates | Checked `submission_id`; none found |
| 3 | 3 NULLs in `writing_style_score` | Filled with the column average |
| 4 | Short subject codes (BIO, PHYS, etc.) | Replaced with full subject names using `CASE` |
| 5 | Categories | Checked `tool`, `actual_type`, `subject` and `grade_level` for spelling, casing and spacing issues; all consistent |
| 6 | 2 `writing_style_score` values above 1 and 7 `perplexity_score` values below 0 | Capped at 1 and 0 respectively |

A backup table (`chatgpt_detection_results_backup`) was created before any changes were made.

### Key cleaning queries

```sql
-- Backup
SELECT * INTO chatgpt_detection_results_backup
FROM chatgpt_detection_results;

-- Convert floats to DECIMAL
ALTER TABLE chatgpt_detection_results ALTER COLUMN confidence_score      DECIMAL(6,4);
ALTER TABLE chatgpt_detection_results ALTER COLUMN writing_style_score   DECIMAL(6,4);
ALTER TABLE chatgpt_detection_results ALTER COLUMN perplexity_score      DECIMAL(6,4);
ALTER TABLE chatgpt_detection_results ALTER COLUMN detection_probability DECIMAL(6,4);

-- Fill NULLs in writing_style_score with the average
UPDATE chatgpt_detection_results
SET writing_style_score = (
    SELECT CAST(AVG(writing_style_score) AS DECIMAL(6,4))
    FROM chatgpt_detection_results
    WHERE writing_style_score IS NOT NULL
)
WHERE writing_style_score IS NULL;

-- Cap out-of-range values
UPDATE chatgpt_detection_results SET writing_style_score = 1 WHERE writing_style_score > 1;
UPDATE chatgpt_detection_results SET perplexity_score = 0 WHERE perplexity_score < 0;
```

## Analysis

### Accuracy, false positives and false negatives by tool

`ai_generated` is treated as the positive class. `mixed` texts are excluded from these rates because they are not clearly AI or human.

```sql
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
```

### Detection rate by subject and grade level

```sql
-- By subject
SELECT subject, COUNT(*) AS total,
       CAST(100.0 * SUM(CASE WHEN detected_as_ai = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS flagged_as_ai_pct,
       CAST(AVG(detection_probability) AS DECIMAL(6,4)) AS avg_detection_probability
FROM chatgpt_detection_results
GROUP BY subject
ORDER BY flagged_as_ai_pct DESC;

-- By grade level
SELECT grade_level, COUNT(*) AS total,
       CAST(100.0 * SUM(CASE WHEN detected_as_ai = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS flagged_as_ai_pct,
       CAST(AVG(detection_probability) AS DECIMAL(6,4)) AS avg_detection_probability
FROM chatgpt_detection_results
GROUP BY grade_level
ORDER BY CASE grade_level
    WHEN 'Freshman' THEN 1 WHEN 'Sophomore' THEN 2 WHEN 'Junior' THEN 3
    WHEN 'Senior' THEN 4 WHEN 'Graduate' THEN 5 END;
```

## Key Findings

**By tool**

| Tool | Accuracy | False positive rate | False negative rate |
|---|---|---|---|
| Copyleaks | 91.72% | 2.67% | 17.45% |
| Turnitin | 90.90% | 5.98% | 14.05% |
| Originality.ai | 90.49% | 0.39% | 24.68% |
| Winston AI | 89.91% | 10.56% | 9.19% |
| GPTZero | 88.08% | 15.09% | 7.28% |

- Overall accuracy is similar across tools (88% to 92%), but their behavior differs sharply.
- Strict tools (GPTZero, Winston AI) catch more AI text but wrongly flag more human writing.
- Lenient tools (Originality.ai, Copyleaks) rarely accuse human writers but miss more AI text.

**By subject:** English (42.14%) and Biology (40.32%) have the highest share of texts flagged as AI; Physics (34.47%) has the lowest.

**By grade level:** Sophomores (40.42%) are flagged most and seniors (35.36%) least, with no clear trend across levels.

> Subject and grade-level rates include all text types, so differences may partly reflect the mix of human, AI and mixed submissions rather than detector bias.

## Notes & Limitations

- 3 missing `writing_style_score` values were filled with the column average (estimates, not real data).
- 9 out-of-range scores were capped to stay within 0 to 1.
- `mixed` texts are excluded from accuracy, false positive and false negative rates.

## Next Steps

- Compare how each tool treats human, AI and mixed text (tool × text type).
- Check false positives for human-written text by subject and grade level.
- Build the dashboard (suggested visuals: false positive vs false negative by tool, accuracy by tool, detection rate by subject and grade level).

## Tools Used

- SQL Server Management Studio (SSMS), SQL Server Express