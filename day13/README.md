# Sleep Health and Lifestyle: Analysis Findings — Day 13

Analysis of the cleaned `Sleep_health` (374 rows) and `Sleep_health_dedup` (132 rows) tables in the `HEALTH` database. All averages below use `Sleep_health_dedup` unless noted, and were cross-checked against the full table for consistency.

## 1. Stress and Sleep

The clearest, most consistent relationship in the dataset.

| Stress Level | People | Avg Sleep | Avg Quality |
|---|---|---|---|
| 3 | 22 | 8.19 | 8.95 |
| 4 | 22 | 7.15 | 7.77 |
| 5 | 21 | 7.44 | 7.76 |
| 6 | 21 | 7.28 | 7.00 |
| 7 | 22 | 6.51 | 5.82 |
| 8 | 24 | 6.04 | 5.75 |

From stress 3 to stress 8, average sleep duration drops ~2.1 hours and average sleep quality drops ~3.2 points. Group sizes are even (21-24 each), so this is well supported.

## 2. Occupation

| Occupation | People | Avg Stress | Avg Quality | Avg Sleep |
|---|---|---|---|---|
| Salesperson | 10 | 7.10 | 5.80 | 6.37 |
| Doctor | 24 | 6.54 | 6.75 | 7.05 |
| Nurse | 29 | 5.76 | 7.07 | 6.97 |
| Lawyer | 15 | 5.13 | 7.73 | 7.38 |
| Teacher | 15 | 5.00 | 6.80 | 6.72 |
| Accountant | 11 | 4.82 | 7.91 | 7.14 |
| Engineer | 22 | 4.23 | 8.14 | 7.80 |

- **Salesperson** has the highest stress and lowest sleep quality (small sample: 10 people, individually verified — not driven by outliers).
- **Engineer** has the lowest stress and best sleep on every measure.
- **Teacher** and **Doctor** don't fit the stress-quality gradient cleanly — occupation affects sleep through more than just stress.
- Scientist (4), Software Engineer (4), and Manager (1) were excluded from occupation comparisons — too small to be reliable.

## 3. Sleep Disorders

| Occupation | People | Insomnia | Sleep Apnea | None | % With Disorder |
|---|---|---|---|---|---|
| Salesperson | 10 | 6 | 2 | 2 | 80.0% |
| Teacher | 15 | 8 | 3 | 4 | 73.3% |
| Nurse | 29 | 3 | 17 | 9 | 69.0% |
| Lawyer | 15 | 2 | 3 | 10 | 33.3% |
| Accountant | 11 | 3 | 0 | 8 | 27.3% |
| Engineer | 22 | 4 | 1 | 17 | 22.7% |
| Doctor | 24 | 2 | 3 | 19 | 20.8% |

Disorder rate does **not** track stress cleanly — Doctor has the second-highest stress but the lowest disorder rate; Nurse and Teacher have high disorder rates despite moderate stress.

**Data quality caveat:** 22 profiles in `Sleep_health_dedup` are identical across every measured variable but carry different `Sleep_Disorder` labels (e.g., the same 42-44 year old Overweight Salesperson profile appears labelled Insomnia, Sleep Apnea, and None). This means `Sleep_Disorder` does not cleanly track the other variables in this dataset, and any disorder-based conclusion should be treated as suggestive rather than solid.

## 4. BMI Drives Sleep Apnea

| BMI Category | People | Sleep Apnea | % |
|---|---|---|---|
| Normal | 73 | 7 | 9.6% |
| Overweight | 52 | 19 | 36.5% |
| Obese | 7 | 4 | 57.1% |

Sleep apnea rate rises sharply and consistently with BMI — a ~6x increase from Normal to Obese, and medically expected (excess weight is a known airway/apnea risk factor). This is the strongest, most trustworthy relationship found in the analysis (though Obese, n=7, is a thin sample).

**Nurses re-examined:** Nurses' high sleep apnea rate is largely explained by BMI — 76% of Nurses in this sample are Overweight, and Overweight people generally have elevated apnea rates. However, even within the same BMI band, Nurses still showed a higher apnea rate than Doctors/Engineers/Accountants (28.6% vs. 5-9% at Normal BMI), suggesting occupation may carry some additional effect beyond BMI alone — though subgroup sizes here (7-22 people) are too small to confirm this.

## 5. BMI, Activity, and Blood Pressure vs. Sleep

| BMI Category | People | Avg Sleep | Avg Quality |
|---|---|---|---|
| Normal | 73 | 7.34 | 7.51 |
| Overweight | 52 | 6.74 | 6.77 |
| Obese | 7 | 6.90 | 6.29 |

BMI is the **strongest, cleanest predictor of sleep quality** found in this analysis (Normal vs. Overweight: -0.6 hrs, -0.74 quality points, on solid sample sizes).

| Activity Band | People | Avg Sleep | Avg Quality |
|---|---|---|---|
| Low (<40) | 26 | 6.94 | 6.69 |
| Medium (40-69) | 58 | 6.85 | 7.00 |
| High (70+) | 48 | 7.44 | 7.58 |

High activity is associated with clearly better sleep, but Low vs. Medium doesn't follow a clean gradient (duration dips slightly at Medium) — likely occupation-driven rather than a pure activity effect.

| BP Category | People | Avg Sleep | Avg Quality |
|---|---|---|---|
| Normal | 15 | 7.33 | 8.00 |
| Stage 1 | 83 | 7.11 | 7.00 |
| Stage 2 | 33 | 6.89 | 7.12 |

Sleep duration declines steadily with rising BP, but sleep quality doesn't track as cleanly (Stage 2 quality is slightly higher than Stage 1). BP's relationship with sleep is weaker than BMI's — likely because BP and BMI are correlated, so BMI may be doing most of the underlying work.

## 6. Gender

| Gender | People | Avg Sleep | Avg Quality | % With Disorder |
|---|---|---|---|---|
| Female | 65 | 7.15 | 7.45 | 52.3% |
| Male | 67 | 7.01 | 6.87 | 37.3% |

Females report both better sleep quality **and** a higher disorder rate — an unresolved, counterintuitive pairing. Not yet explained; likely tangled up with occupation mix (not yet checked).

## 7. Age (Confounded with Occupation)

| Age Band | People | Avg Sleep | Avg Quality | Avg Stress | % Disorder |
|---|---|---|---|---|---|
| Under 30 | 11 | 6.30 | 5.55 | 7.36 | 54.5% |
| 30-39 | 52 | 7.08 | 7.08 | 5.52 | 26.9% |
| 40-49 | 40 | 6.91 | 6.95 | 5.85 | 60.0% |
| 50+ | 29 | 7.63 | 8.17 | 4.44 | 51.7% |

At face value, stress declines and sleep improves with age. But occupation and age are heavily entangled:

| Occupation | Avg Age |
|---|---|
| Software Engineer | 30 |
| Doctor | 33 |
| Scientist | 33 |
| Lawyer | 39 |
| Teacher | 39 |
| Accountant | 39 |
| Salesperson | 41 |
| Manager | 45 |
| Engineer | 45 |
| Nurse | 48 |

Nurses (older, higher disorder rate) skew the 40-49/50+ bands; Engineers (older, low stress) skew 50+ favorably. **Testing age within single occupations:**

- **Within Doctors** (n=3 vs. 21): 40+ shows better sleep/quality/stress, but the 40+ group is only 3 people — not reliable.
- **Within Nurses** (n=22 vs. 7, better balanced): 40+ shows modestly better sleep and quality, but a **higher** disorder rate (72.7% vs 57.1%) than Under-40 — the opposite of what improving sleep quality would predict.

**Conclusion:** a genuine, modest within-occupation age effect on stress/quality exists, but it is smaller than the raw age-band numbers suggest, and does not extend to sleep disorder prevalence, which behaves inconsistently with age in both occupations tested.

## Key Takeaways

1. **Stress is the single most reliable predictor of sleep duration and quality** in this dataset.
2. **BMI is the most reliable predictor of sleep apnea and of general sleep quality.**
3. **Occupation is a major confound** running through nearly every other variable (age, stress, disorder rate) — findings that look like "age effects" or "activity effects" are often partly occupation effects.
4. **Sleep_Disorder is the least trustworthy variable** in the dataset: 22 profiles carry conflicting labels despite identical measurements elsewhere, so disorder-based conclusions throughout this analysis should be read as suggestive, not solid.
5. **Open item:** the gender pattern (females: better quality, more disorders) is unresolved and worth checking against occupation mix next.

## Not Yet Explored
- Gender × occupation mix (to explain the gender oddity above)
- Heart rate vs. BMI/activity
- Daily steps as a standalone predictor (only used via activity level so far)