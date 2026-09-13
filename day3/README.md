# Day 3: Netflix Titles — Data Exploration & Cleaning

## Dataset
Netflix Titles dataset (movies and TV shows), imported into SQL Server
Total records: 8,807

## Summary
Explored the raw Netflix dataset to understand its structure, identify missing values across all columns, and uncovered a subtle data quality issue affecting several rows before finalizing the cleaning process.

## Column Overview

| Column | Description |
|---|---|
| show_id | Unique identifier for each title |
| type | Movie or TV Show |
| title | Name of the title |
| director | Director(s) of the title |
| cast | Actors featured |
| country | Country of production |
| date_added | Date the title was added to Netflix |
| release_year | Original release year |
| rating | Content rating (e.g., PG, TV-MA) |
| duration | Runtime (minutes) or number of seasons |
| listed_in | Genre(s) |
| description | Short synopsis |

## Null Value Summary

| Column | Missing Count |
|---|---|
| director | 2,634 |
| cast | 825 |
| country | 831 |
| date_added | 10 |
| rating | 4 |
| duration | 3 |
| show_id, type, title, release_year, listed_in, description | 0 |

## Cleaning Steps

**High-null columns (director, cast, country)**
- Filled missing values with `'Unknown'` rather than deleting rows, since these fields are non-critical for most trend analysis and dropping rows would lose significant data

**Low-null columns (date_added, rating, duration)**
- Manually inspected each row individually due to small count

## Data Quality Issue Found: Column Shift

Discovered 7 rows where values had shifted one column to the left — likely caused by a missing value in the original source CSV. Symptoms:
- `duration` values (e.g., "74 min") appeared incorrectly in the `rating` column
- `duration` column itself was left NULL

**Affected titles:**
- 3 Louis C.K. stand-up specials (Movies)
- 4 additional titles across Anime, Kids' TV, and Drama genres

**Resolution:**
- Recovered and restored correct `duration` values for all 7 affected rows
- For the Louis C.K. titles: reclassified `listed_in` to `'Stand-Up Comedy'` (based on title content) and set `rating` to `'TV-MA'`, a well-documented real-world rating for this specific content — a confident, informed inference
- For the remaining 4 titles: set `rating` to `'Unknown'` rather than guess, since genre alone (e.g., "Kids' TV", "Dramas") wasn't specific enough to reliably infer an exact rating

## Key Takeaway
Real-world datasets often contain subtle structural errors beyond simple missing values. Catching and documenting a column-shift issue — and knowing when to confidently infer a value versus when to honestly mark it "Unknown" — is as important as handling standard NULLs.

## Files
- `Day3_netflix_exploring&cleaning.sql` — exploration, null-checking and cleaning queries

