# DAY 17

# Analysis README: `assignment_design_efficacy`

## Overview

| Item | Detail |
|---|---|
| Database | `Education` |
| Table | `assignment_design_efficacy` (cleaned; see `README_data_cleaning.md`) |
| Tool | SQL Server (SSMS) |
| Rows | 240 (8 assignment designs x 30 rows each) |
| Main metric | `efficacy_score` (whole-number percentage, 0-100) |

**Question:** which assignment design is most effective, and do cost, faculty workload, class size or subject change that?

Note: `AVG()` on an INT column truncates decimals, so averages are computed with `AVG(column * 1.0)` and rounded to 1 decimal place.

---

## Key Findings

1. **Design type is the dominant factor.** Efficacy ranges from 19.4 (Traditional) to 89.0 (Oral Defense). Cost, workload, class size and subject all matter far less.
2. **Oral Defense is consistently the best** (first in every subject, minimum score 74). **Traditional is consistently the worst** (last in every subject, scores between 8 and 29).
3. **Cost does not buy efficacy.** No consistent relationship overall or within designs.
4. **Faculty workload has no consistent effect.** Top designs perform well even at low workload.
5. **Class size has no consistent effect.** The higher overall average in large classes reflects the mix of designs, not class size itself.
6. **The middle designs overlap heavily** (Multi-Stage, Scaffolded, Process-Oriented, Reflective), so a firm ranking among them is not supported with 30 rows each.

---

## 1. Overall performance by design

```sql
SELECT design_type,
       COUNT(*)                                  AS n,
       ROUND(AVG(efficacy_score * 1.0), 1)       AS avg_efficacy,
       ROUND(AVG(student_engagement * 1.0), 1)   AS avg_engagement,
       ROUND(AVG(learning_outcome * 1.0), 1)     AS avg_outcome,
       ROUND(AVG(ai_detection_rate * 1.0), 1)    AS avg_ai_detection,
       ROUND(AVG(student_satisfaction * 1.0), 1) AS avg_satisfaction
FROM assignment_design_efficacy
GROUP BY design_type
ORDER BY avg_efficacy DESC;
```

| Design | Efficacy | Engagement | Outcome | AI detection | Satisfaction |
|---|---|---|---|---|---|
| Oral Defense | 89.0 | 60.8 | 66.6 | 45.6 | 63.2 |
| Multi-Stage | 73.2 | 58.1 | 70.8 | 51.4 | 58.2 |
| Scaffolded | 71.8 | 60.6 | 69.2 | 50.4 | 68.6 |
| Process-Oriented | 70.5 | 59.8 | 71.1 | 51.1 | 64.8 |
| Reflective | 65.8 | 63.2 | 69.6 | 56.4 | 65.4 |
| Project-Based | 59.5 | 58.4 | 69.6 | 48.3 | 62.2 |
| Peer-Review | 52.4 | 59.7 | 68.9 | 44.7 | 65.2 |
| Traditional | 19.4 | 62.3 | 67.3 | 48.8 | 65.8 |

**Observations**

- Efficacy has a huge spread (about 70 points), while engagement (58-63), learning outcome (67-71) and satisfaction (58-69) are much flatter.
- Efficacy does not line up with learning outcome or satisfaction. Oral Defense has the highest efficacy but the lowest learning outcome, and Traditional has the lowest efficacy but high engagement and satisfaction. It is worth confirming what `efficacy_score` actually measures.
- The meaning of `ai_detection_rate` (is lower better or worse?) should be confirmed before interpreting it.

## 2. Spread of efficacy within each design

```sql
SELECT design_type,
       MIN(efficacy_score)             AS min_eff,
       MAX(efficacy_score)             AS max_eff,
       ROUND(STDEV(efficacy_score), 1) AS stdev_eff
FROM assignment_design_efficacy
GROUP BY design_type
ORDER BY stdev_eff DESC;
```

| Design | Min | Max | Std dev |
|---|---|---|---|
| Peer-Review | 28 | 81 | 11.1 |
| Reflective | 46 | 85 | 10.8 |
| Multi-Stage | 53 | 95 | 10.4 |
| Scaffolded | 50 | 85 | 9.5 |
| Process-Oriented | 43 | 89 | 8.9 |
| Project-Based | 37 | 77 | 8.8 |
| Oral Defense | 74 | 100 | 7.9 |
| Traditional | 8 | 29 | 6.7 |

**Observations**

- Oral Defense's lowest score (74) is higher than the average of every other design, so its lead is not driven by a few extreme values. It reaches 100, so it is worth checking whether scores are capped.
- Traditional is consistently weak (every score between 8 and 29).
- Peer-Review is the least predictable (28 to 81).

## 3. Efficacy by subject and design

```sql
SELECT subject, design_type,
       COUNT(*)                            AS n,
       ROUND(AVG(efficacy_score * 1.0), 1) AS avg_efficacy
FROM assignment_design_efficacy
GROUP BY subject, design_type
ORDER BY subject, avg_efficacy DESC;
```

| Design | Humanities | Social Sciences | STEM |
|---|---|---|---|
| Oral Defense | 85.8 | 90.1 | 90.9 |
| Multi-Stage | 74.5 | 74.8 | 70.9 |
| Scaffolded | 68.3 | 71.0 | 77.1 |
| Process-Oriented | 72.0 | 63.9 | 73.3 |
| Reflective | 62.3 | 70.3 | 63.8 |
| Project-Based | 58.7 | 59.3 | 60.8 |
| Peer-Review | 51.6 | 55.5 | 51.0 |
| Traditional | 18.0 | 21.0 | 20.4 |

**Observations**

- Oral Defense ranks first and Traditional last in every subject.
- Shifts among the middle designs (5-10 points) are not reliable: groups range from 4 to 17 rows (for example, Multi-Stage in Humanities has n=4).

## 4. Implementation cost

```sql
-- Within each design
SELECT design_type, implementation_cost,
       COUNT(*)                            AS n,
       ROUND(AVG(efficacy_score * 1.0), 1) AS avg_efficacy
FROM assignment_design_efficacy
GROUP BY design_type, implementation_cost
ORDER BY design_type,
         CASE implementation_cost WHEN 'Low' THEN 1 WHEN 'Medium' THEN 2 ELSE 3 END;

-- Overall
SELECT implementation_cost,
       COUNT(*)                            AS n,
       ROUND(AVG(efficacy_score * 1.0), 1) AS avg_efficacy
FROM assignment_design_efficacy
GROUP BY implementation_cost
ORDER BY CASE implementation_cost WHEN 'Low' THEN 1 WHEN 'Medium' THEN 2 ELSE 3 END;
```

| Cost | n | Avg efficacy |
|---|---|---|
| Low | 78 | 63.0 |
| Medium | 91 | 64.7 |
| High | 71 | 59.8 |

| Design | Low | Medium | High |
|---|---|---|---|
| Oral Defense | 90.5 | 88.1 | 88.2 |
| Multi-Stage | 69.8 | 75.9 | 72.3 |
| Scaffolded | 71.9 | 71.3 | 72.6 |
| Process-Oriented | 69.9 | 68.6 | 73.9 |
| Reflective | 68.2 | 66.7 | 61.5 |
| Project-Based | 61.5 | 57.3 | 58.1 |
| Peer-Review | 46.3 | 53.7 | 54.3 |
| Traditional | 19.3 | 19.3 | 19.5 |

**Observations**

- No consistent relationship between cost and efficacy, overall or within designs.
- High-cost is slightly lowest overall, likely a design-mix effect: the High group has 12 Traditional rows but only 5 Oral Defense rows, while the Low group has 10 Traditional and 11 Oral Defense.
- Oral Defense's best result comes from its low-cost version (90.5, n=11). Traditional stays at about 19 at every cost level.

## 5. Faculty workload

```sql
SELECT design_type, faculty_workload,
       COUNT(*)                            AS n,
       ROUND(AVG(efficacy_score * 1.0), 1) AS avg_efficacy
FROM assignment_design_efficacy
GROUP BY design_type, faculty_workload
ORDER BY design_type,
         CASE faculty_workload WHEN 'Low' THEN 1 WHEN 'Medium' THEN 2 ELSE 3 END;
```

| Design | Low | Medium | High |
|---|---|---|---|
| Oral Defense | 89.0 | 87.2 | 89.6 |
| Multi-Stage | 76.5 | 66.4 | 74.4 |
| Scaffolded | 71.6 | 77.7 | 67.7 |
| Process-Oriented | 70.5 | 70.6 | 70.5 |
| Reflective | 64.1 | 65.1 | 69.9 |
| Project-Based | 58.9 | 59.9 | 59.5 |
| Peer-Review | 50.5 | 51.3 | 55.5 |
| Traditional | 20.1 | 18.0 | 19.8 |

**Observations**

- Oral Defense, Traditional, Process-Oriented and Project-Based are flat across workload levels.
- Best trade-offs (strong efficacy at low workload): Oral Defense (89.0, n=7) and Multi-Stage (76.5, n=13).
- Reflective and Peer-Review rise slightly with workload (about 5 points), but groups are small (n as low as 4), so this may be noise.

## 6. Class size

```sql
-- Overall, by size band
SELECT 
    CASE WHEN class_size < 50  THEN '1. Small (<50)'
         WHEN class_size < 100 THEN '2. Medium (50-99)'
         ELSE                       '3. Large (100+)' END AS size_band,
    COUNT(*)                            AS n,
    ROUND(AVG(efficacy_score * 1.0), 1) AS avg_efficacy
FROM assignment_design_efficacy
GROUP BY CASE WHEN class_size < 50  THEN '1. Small (<50)'
              WHEN class_size < 100 THEN '2. Medium (50-99)'
              ELSE                       '3. Large (100+)' END
ORDER BY size_band;

-- Within each design
SELECT design_type,
       CASE WHEN class_size < 50  THEN '1. Small (<50)'
            WHEN class_size < 100 THEN '2. Medium (50-99)'
            ELSE                       '3. Large (100+)' END AS size_band,
       COUNT(*)                            AS n,
       ROUND(AVG(efficacy_score * 1.0), 1) AS avg_efficacy
FROM assignment_design_efficacy
GROUP BY design_type,
         CASE WHEN class_size < 50  THEN '1. Small (<50)'
              WHEN class_size < 100 THEN '2. Medium (50-99)'
              ELSE                       '3. Large (100+)' END
ORDER BY design_type, size_band;
```

| Size band | n | Avg efficacy |
|---|---|---|
| Small (<50) | 43 | 59.4 |
| Medium (50-99) | 70 | 59.0 |
| Large (100+) | 127 | 65.9 |

| Design | Small | Medium | Large |
|---|---|---|---|
| Oral Defense | 86.7 | 84.3 | 92.1 |
| Multi-Stage | 68.5 | 74.0 | 73.4 |
| Scaffolded | 67.7 | 72.9 | 71.9 |
| Process-Oriented | 69.6 | 65.8 | 73.5 |
| Reflective | 69.8 | 64.8 | 64.8 |
| Project-Based | 60.2 | 55.1 | 60.9 |
| Peer-Review | 57.9 | 48.9 | 51.6 |
| Traditional | 17.0 | 16.7 | 23.7 |

**Observations**

- Large classes score higher overall, but within designs the direction is mixed (three higher in Large, two higher in Small, three flat).
- Design mix explains most of the overall gap: Traditional makes up about 19% of Small and 16% of Medium classes but only about 9% of Large classes.
- Several groups are too small to trust (Multi-Stage Small n=2, Scaffolded Small n=3, most Small groups n=5-8).

---

## Limitations

- Only 30 rows per design, and subgroup comparisons often have fewer than 10 rows, so differences of about 5 points should be treated as tentative.
- Averages and group comparisons only: no significance tests were run.
- The data is observational, so differences between groups may reflect other factors, such as the mix of designs across cost, workload and class-size levels.
- A class size and efficacy correlation query was suggested but not run.

