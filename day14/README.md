# Spotify Tracks Analysis

**Goal:** Explore 113,999 Spotify tracks across 114 genres to understand what drives popularity — comparing genres, audio features, and artists.

**Tools:** SQL Server (data cleaning), Power BI (visualization & dashboard)

---

## Process

### 1. Data Cleaning (SQL Server)
- Imported a raw Spotify dataset (~114,000 rows, 21 columns) into SQL Server, resolving several import errors along the way (NULL constraint conflicts, column length overflow, numeric range overflow).
- Checked for missing values across all 21 columns — found NULLs concentrated in `artists`, `album_name`, `track_name`, `energy`, `loudness`, `acousticness`, and `valence`.
- Dropped 1 row missing all three identifying fields (artist, album, track name), as it was unusable for any track-level analysis.
- Investigated ~16,600 apparent "duplicate" rows (same artist/track/album) by inspecting `track_id` and `track_genre` — confirmed these were **not data errors**, but legitimate entries where the same song appears under multiple genre tags and/or multiple album releases. No rows were removed on this basis.
- Filled remaining NULLs in `energy`, `loudness`, `acousticness`, and `valence` using **median imputation** (rather than mean) to avoid distortion from outliers, preserving the full row count.

### 2. Dashboard Build (Power BI)
Built a 4-page interactive dashboard:

| Page | Focus |
|---|---|
| **1. Overview** | Key stats (total tracks, artists, genres, avg. popularity) + Top 10 Genres and Top 10 Artists by average popularity |
| **2. Genre Deep Dive** | Audio feature comparison (danceability, energy, acousticness, valence) by genre, with an interactive genre filter and a top-tracks table |
| **3. Popularity Drivers** | Scatter plots examining danceability vs. popularity and energy vs. popularity |
| **4. Top Artists** | Most prolific artists by track count |

---

## Key Insights

1. **Niche and mood-based genres outperform mainstream "pop."** Pop-film, k-pop, and mood genres like chill and sad top the popularity charts, outranking plain "pop," which ranks last among the top 10. Several top artist entries are also collaborations, suggesting features may boost a track's popularity.

2. **High-popularity genres favor upbeat, produced sound.** Genres like kids, chicago-house, and reggaeton show the highest danceability, while acousticness stays low across most top genres — suggesting popularity leans toward produced, danceable sound over acoustic simplicity.

3. **Audio features alone don't predict popularity.** Neither danceability nor energy shows a strong correlation with popularity among top genres — popularity appears to be driven more by factors like artist recognition, cultural relevance, or marketing than by these specific audio characteristics.

4. **Legacy catalogs dominate raw track count.** The Beatles lead with 279 tracks, followed closely by George Jones and Stevie Wonder — legacy artists with decades-long catalogs outproducing many modern acts in sheer volume.

---

## Dashboard

**Page 1 — Overview**
![Overview page]

**Page 2 — Genre Deep Dive**
![Genre Deep Dive page]

**Page 3 — Popularity Drivers**
![Popularity Drivers page]

**Page 4 — Top Artists**
![Top Artists page]

---

