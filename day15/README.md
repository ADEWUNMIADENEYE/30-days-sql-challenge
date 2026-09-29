# Student AI Use in Academic Submissions — Dashboard Project

## Overview
This project analyzes a dataset of student assignment submissions to explore how AI-generated content relates to submission volume, assignment type, and academic performance. The data lives in a SQL Server database and is visualized in a two-page Power BI dashboard.

## Data Source
- **Database:** `Education`
- **Table:** `ai_essay_submissions`
- **Rows:** 3,000
- **Columns:**
  | Column | Description |
  |---|---|
  | `submission_id` | Unique ID per submission (e.g. AI0001) |
  | `semester` | Fall 2025, Spring 2026, Summer 2026, Fall 2026 |
  | `assignment_type` | Case Study, Essay, Lab Report, Literature Review, Research Paper |
  | `is_ai_generated` | Boolean flag — whether the submission is AI-generated |
  | `ai_probability` | Likelihood the text is AI-generated (cleaned to a whole-number percentage) |
  | `word_count` | Word count of the submission (cleaned to a whole number) |
  | `cited_references` | Number of citations used |
  | `similarity_score` | Text similarity score |
  | `submission_date` | Date/time of submission |
  | `grade` | Final grade for the submission |

## Data Cleaning
1. **`word_count`** — rounded from long decimals to whole numbers.
2. **`ai_probability`** — originally a 0–1 decimal; multiplied by 100 and rounded to a whole-number percentage.
3. Both columns converted to `INT` after rounding.

```sql
UPDATE ai_essay_submissions
SET ai_probability = ROUND(ai_probability * 100, 0),
    word_count     = ROUND(word_count, 0);

ALTER TABLE ai_essay_submissions ALTER COLUMN ai_probability INT;
ALTER TABLE ai_essay_submissions ALTER COLUMN word_count INT;
```

4. Added a calculated column `AI or Human` (`IF(is_ai_generated = TRUE(), "AI", "Human")`) in Power BI for readable chart legends.

## Dashboard Structure

### Page 1 — Submission Trends
Focuses on **volume**: how many submissions came in, broken down by assignment type and semester.
- Total Submissions, Avg Grade
- Top / Lowest Semester
- Top / Lowest Assignment Type
- Bar chart: submission counts by assignment type, colored by semester (Fall 2025, Spring 2026, Summer 2026, Fall 2026)

**Key finding:** Fall 2026 is the peak submission period across every assignment type; Case Study has the lowest overall volume.

### Page 2 — Analysis of AI Usage Patterns
Focuses on the **effect of AI use** on academic outcomes.
- % AI Generated / % Human Written
- Top Assignment Type for AI vs Human submissions
- Bar chart: AI vs Human submission counts by assignment type
- Scatter plot: AI probability vs. grade, filtered to the top 20 highest-graded submissions

**Key finding:** 40% of submissions were AI-generated, 60% human-written. AI use is highest in Literature Review and lowest in Lab Report. Among the top 20 highest-graded submissions, most cluster at lower AI-probability scores — suggesting a possible link between human authorship and stronger academic performance.

## Key DAX Measures
```
Total Submissions = COUNTROWS(ai_essay_submissions)

AI Generated Submissions =
CALCULATE(COUNTROWS(ai_essay_submissions), ai_essay_submissions[is_ai_generated] = TRUE())

Human Written Submissions =
CALCULATE(COUNTROWS(ai_essay_submissions), ai_essay_submissions[is_ai_generated] = FALSE())

% AI Generated = DIVIDE([AI Generated Submissions], [Total Submissions])
% Human Written = DIVIDE([Human Written Submissions], [Total Submissions])

Avg Grade = AVERAGE(ai_essay_submissions[grade])
```

Top/Lowest assignment type and semester measures use `SUMMARIZE` + `MAXX`/`MINX` with `CONCATENATEX` to handle ties gracefully (e.g. "Research Paper & Lab Report" when both are tied at the top).

## Color Scheme
- **Navy** `#1E3A8A` — Human-written / Fall 2026 highlight
- **Purple** `#7C3AED` — AI-generated / card titles
- **Grey** `#94A3B8` — Fall 2025 (lowest volume)
- **Green** `#10B981` — Spring 2026
- **Amber** `#FBBF24` — Summer 2026

## Notes & Caveats
- Submission dates in this dataset extend into "Fall 2026," which is ahead of the current real-world date — treat this as synthetic/simulated data for the purposes of the exercise, not a real forecasted trend.
- The AI-vs-grade relationship is based on a small (20-row) top-performer sample; it's suggestive, not statistically conclusive.