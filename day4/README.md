# Day 4: Netflix Titles — Deep Dive Analysis (Content, Country, Ratings & Trends)

## Dataset
Netflix Titles dataset — 8,807 total records
Context: Netflix launched globally in 1998 and became available in Nigeria in 2016.

## Summary
Conducted a detailed breakdown of Netflix's content library by type, production country, release trends, and content ratings to uncover key patterns in what Netflix offers and where its content comes from.

## Key Findings

### Content Type Breakdown
| Type | Count |
|---|---|
| **Movies** | 6,131 (highest) |
| **TV Shows** | 2,676 (lowest) |

**Insight:** Netflix's catalog is dominated by movies — roughly 2.3x more movies than TV shows.

### Country of Production — Highest & Lowest
| Country | Occurrences |
|---|---|
| **United States** | 2,818 — highest overall |
| **India** | 972 — 2nd highest |
| **United Kingdom** | 419 |
| **Canada** | 181 |
| **Unknown/Missing** | 831 |

**Countries appearing only once (lowest representation):**
Belarus, Bulgaria, Cambodia, Cameroon, Croatia, Cyprus, Finland, Georgia, Guatemala, Luxembourg, Mauritius, Mozambique, Namibia, Senegal, Venezuela, West Germany, Zimbabwe

**Insight:** The US dominates Netflix's content library by a wide margin, while many smaller countries are represented by just a single title — showing how concentrated content production is among a few major markets.

### TV Show Releases by Year — Highest & Lowest
| Year | TV Shows Released |
|---|---|
| **2020** | 436 — highest |
| 2021 | 315 |
| 2019 | 397 |
| **2005** | 13 — lowest |
| 2006 | 14 |
| 2007 | 14 |

**Insight:** TV show production on Netflix grew steadily and peaked in 2020, likely tied to increased global streaming demand (and possibly pandemic-era content consumption). Earlier years (2005–2007) show minimal output, consistent with Netflix's slower early growth before its major streaming expansion.

### Content Rating Breakdown — Highest & Lowest
| Rating | Total | Meaning |
|---|---|---|
| **TV-MA** | 3,207 — highest | Mature audience only |
| NR | 863 | Not Rated |
| R | 799 | Restricted |
| TV-14 | 2,160 | Parents cautioned, under 14 |
| PG-13 | 491 | Parents strongly cautioned |
| TV-Y | 307 | Suitable for all children |
| PG | 334 | Parental guidance suggested |
| TV-PG | 220 | Parental guidance suggested (TV) |
| TV-G | 220 | General audience |
| TV-Y7 | 334 | Suitable for ages 7+ |
| NC-17 | 41 | Adults only |
| UR | 80 | Unrated |
| Unknown | 5 | Missing/unclear rating |
| **TV-Y7-FV** | 6 — lowest (excluding rare combos) | Fantasy violence, ages 7+ |
| TV-G or TV-Y (combo) | 1 — lowest overall | Rare/misformatted entry |

**Insight:** TV-MA is by far the most common rating on Netflix, meaning the majority of content is aimed at mature/adult audiences rather than children or general audiences. This reflects Netflix's broader content strategy of catering heavily to adult viewers, with family-friendly content (TV-Y, TV-G, PG) making up a noticeably smaller share of the catalog.


### Co-Productions (Multiple Countries)
Found numerous titles produced across 2+ countries (e.g., "United Kingdom, United States", "Argentina, Chile, Peru"), confirming that a meaningful share of Netflix's catalog consists of international co-productions rather than single-country content.

## Data Quality Notes
- 831 records have missing/unknown country data
- Country field often contains multiple comma-separated values, requiring careful handling in country-level analysis
- Some records had column-shift errors (see Day 3 notes) which were corrected before this analysis

## Files
- `Day4_netflix_deep_analysis.sql`
- `Day4_netflix_analysis_results.csv`
-`Day4_netflix_analysis_results.csv2`
-`Day4_netflix_analysis_results.csv3`
-`Day4_netflix_analysis_results.csv4`
-`Day4_netflix_analysis_results.csv5`
-`Day4_netflix_analysis_results.csv6`
-`Day4_netflix_analysis_results.csv7`
-`Day4_netflix_analysis_results.csv8`
-`Day4_netflix_analysis_results.csv9`
-`Day4_netflix_analysis_results.csv10`


## Reflection
This analysis reinforced how much richer real-world datasets are compared to clean textbook examples — from country co-productions to inconsistent formatting, every layer required careful thought before drawing conclusions.