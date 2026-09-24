# DAY 11

# Online Food Delivery Dataset: Analysis README

## Overview

This document summarizes the exploratory analysis of the online food delivery customer survey (Bangalore, India), run in SQL Server on the cleaned table.

- **Database:** `Sales_Data`
- **Table analyzed:** `online_food_clean` (381 customers, one row per customer)
- **Raw table:** `online_food` (unchanged original, 388 rows)
- **Cleaning steps:** see `README_data_cleaning.md`
- **Main outcome measures:** `Output` (1/0) and `Feedback` (Positive/Negative)

**Important:** the meaning of `Output` was not confirmed from a data dictionary. It appears to be a positive outcome that goes along with satisfaction (see section 5), but the exact definition should be checked against the source before these findings are reported.

## Data Fix Made During Analysis

While comparing Graduate and Post Graduate customers within each occupation, a filter on `'Self Employed'` returned no rows. A character-length check showed the stored value was misspelled as **"Self Employeed"** (14 characters instead of 13).

- **Scope:** all 53 Self Employed rows carried the same misspelling, so earlier group-by results were still correct; there was one label with a typo, not two labels.
- **Fix applied to `online_food_clean`:**

```sql
UPDATE online_food_clean
SET Occupation = 'Self Employed'
WHERE Occupation = 'Self Employeed';
```

- **Check:** after the update, `Self Employed` shows length 13 and 53 rows. Totals are unchanged (Employee 116, House wife 9, Self Employed 53, Student 203 = 381).
- **Note:** this fix was made after `README_data_cleaning.md` was written, so it is documented here rather than in that file. The raw `online_food` table still contains the original spelling.

## Baseline

| Measure | Value |
|---|---|
| Customers | 381 |
| Output = 1 | 78% (about 297 customers) |
| Positive feedback | 81.9% (312 customers) |
| Average age | 24.6 |

All group results below are compared with the 78% Output baseline.

## Findings

### 1. Occupation is the strongest factor

| Occupation | Customers | Output % |
|---|---|---|
| Student | 203 | 89.2 |
| Employee | 116 | 64.7 |
| Self Employed | 53 | 64.2 |
| House wife | 9 | 77.8 (too small to interpret) |

Students are more than half of all customers and have a much higher Output rate than employees or self-employed customers. This pattern held up in every follow-up check below.

### 2. Income adds little once occupation is known

| Income band | Customers | Output % |
|---|---|---|
| No Income | 184 | 87.5 |
| Below 10000 | 24 | 79.2 |
| 10001 to 25000 | 44 | 72.7 |
| 25001 to 50000 | 68 | 60.3 |
| More than 50000 | 61 | 72.1 |

The rate falls as income rises but not steadily. Every customer with No Income is either a Student (175) or a House wife (9), so the No Income band is essentially the student group. Within employees, rates by income band stay in a narrow range (73.9%, 62.7%, 68.6% for the three bands with reasonable numbers). Many occupation-by-income groups are too small to interpret.

### 3. Customer type makes almost no difference

| Customer type | Customers | Output % | Positive feedback % |
|---|---|---|---|
| Regular | 215 | 79.1 | 81.9 |
| Frequent | 144 | 76.4 | 81.9 |
| New | 22 | 77.3 | 81.8 |

All three are within about 3 points of the baseline. How often someone orders (Customer_Type) does not predict Output or Feedback. This also suggests `Output` is not simply a measure of ordering frequency.

### 4. Age matters within employees

| Age band | Customers | Output % |
|---|---|---|
| Under 22 | 37 | 81.1 |
| 22-24 | 177 | 89.3 |
| 25-27 | 107 | 67.3 |
| 28+ | 60 | 61.7 |

Age and occupation overlap, so age was checked within occupation (cutoff at 25):

| Age group | Occupation | Customers | Output % |
|---|---|---|---|
| Under 25 | Student | 175 | 89.1 |
| 25+ | Student | 28 | 89.3 |
| Under 25 | Employee | 29 | 93.1 |
| 25+ | Employee | 87 | 55.2 |
| 25+ | Self Employed | 44 | 68.2 |
| Under 25 | Self Employed | 9 | 44.4 (too small) |

- Students are high whatever their age.
- Employees split sharply: under 25 behave like students (93.1%), while 25+ are much lower (55.2%).
- Among employees, marital status does not explain the gap: 25+ Married 57.6% (59), 25+ Single 54.2% (24), Under 25 Single 95.5% (22).
- The under-25 employee group is small (29), and the cutoff of 25 was chosen by the analyst, so this is a pattern to note, not a firm result. The data cannot say why (for example, seniority or time in the workforce are not recorded).

### 5. Output and Feedback are strongly linked but not identical

| | Positive feedback | Negative feedback | Total |
|---|---|---|---|
| Output = 1 | 279 | 18 | 297 |
| Output = 0 | 33 | 51 | 84 |

- 93.9% of Output = 1 customers gave Positive feedback, versus 39.3% of Output = 0 customers.
- The two columns agree for 330 of 381 customers (86.6%) and disagree for 51, so Feedback is not a copy of Output.
- This is an association only; it does not show which one influences the other.

### 6. Family size, education, and gender add little after accounting for occupation

**Family size**

| Family size | Customers | Output % |
|---|---|---|
| 1 | 22 | 77.3 |
| 2 | 100 | 78.0 |
| 3 | 115 | 80.0 |
| 4 | 63 | 85.7 |
| 5 | 53 | 73.6 |
| 6 | 28 | 60.7 |

Size 6 looked low, but only 6 of its 28 customers are students (about 21%, versus about 56% in the other groups), so the dip is mostly occupation mix. Within occupation, employees and self-employed customers drift down slightly as family size grows, but those cells are small (8 to 11 customers) and weak.

**Education (Graduate vs Post Graduate, by occupation)**

| Occupation | Graduate | Post Graduate |
|---|---|---|
| Employee | 58.2 (67) | 73.0 (37) |
| Self Employed | 64.3 (28) | 64.3 (14) |
| Student | 86.7 (75) | 90.8 (120) |

Overall, Post Graduates looked higher (84.8% vs 72.3%), but 70% of Post Graduates are students versus 43% of Graduates. Within occupation the gap is small or absent (none for Self Employed, 4 points for Students), with only Employees showing a larger gap on a small sample. Ph.D (23) and School or below (14) are too small to interpret.

**Gender (by occupation, House wife excluded)**

| Occupation | Female | Male |
|---|---|---|
| Student | 91.0 (89) | 87.7 (114) |
| Employee | 59.2 (49) | 68.7 (67) |
| Self Employed | 43.8 (16) | 73.0 (37) |

The direction of the gap flips between occupations, and the largest gap (Self Employed) rests on 16 women. No consistent gender effect is supported.

### 7. Location could not be analyzed reliably

Only six pin codes have 10 or more customers, together covering about 100 of 381 customers. The largest, 560009 (36 customers, 88.9%), is mostly students, so its high rate likely reflects occupation. The other five areas have 11 to 16 customers each, too few to rank. Latitude and longitude are largely shared per area, so they give the same picture as pin code.

## Summary

1. Occupation is the main factor: students about 89%, employees and self-employed about 64%.
2. Age matters within employees: under 25 look like students, 25+ are much lower (small sample for the younger group).
3. Income, customer type, family size, education, gender, and location add little once occupation is accounted for, or are too inconsistent or too small to call.
4. Output and Feedback are strongly linked but not identical.

## Limitations

- **`Output` is not defined** in the material used here. Confirm its meaning from the source before reporting.
- **Small groups.** Many cells have fewer than 30 customers (and some fewer than 10), so their percentages can swing by 10 or more points with a few people. Rows with fewer than about 10 customers were treated as uninterpretable.
- **Many comparisons.** Each variable was cut several ways, which raises the chance that some slices look striking by chance. Weak or inconsistent gaps should not be reported as findings.
- **Association, not cause.** These are survey data, so patterns show how variables go together, not why.
- **No customer ID or timestamp.** Only 7 likely duplicate rows were removed (see the cleaning README); the other 59 groups of identical rows were kept because they share locations with other customers and may be different people.
- **Analyst-chosen cutoffs** (such as age 25 and the family-size groups) can change how patterns look.
- **Survey population.** The sample skews young and student-heavy, so results may not generalize to all food-delivery customers.