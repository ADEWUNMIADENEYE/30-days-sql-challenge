--Create a database called Sportify
CREATE DATABASE Sportify
ALTER DATABASE Sportify MODIFY NAME = Spotify
USE Spotify


SELECT*
FROM spotify

SELECT COUNT(*)
FROM spotify

EXEC sp_rename 'sportify', 'spotify';

SELECT DATA_TYPE, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE DATA_TYPE = 'float'

SELECT * FROM spotify 
WHERE energy IS NULL 
   OR loudness IS NULL 
   OR acousticness IS NULL 
   OR valence IS NULL;

--Checking out for nulls
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN column1 IS NULL THEN 1 ELSE 0 END) AS null_column1,
    SUM(CASE WHEN track_id IS NULL THEN 1 ELSE 0 END) AS null_track_id,
    SUM(CASE WHEN artists IS NULL THEN 1 ELSE 0 END) AS null_artists,
    SUM(CASE WHEN album_name IS NULL THEN 1 ELSE 0 END) AS null_album_name,
    SUM(CASE WHEN track_name IS NULL THEN 1 ELSE 0 END) AS null_track_name,
    SUM(CASE WHEN popularity IS NULL THEN 1 ELSE 0 END) AS null_popularity,
    SUM(CASE WHEN duration_ms IS NULL THEN 1 ELSE 0 END) AS null_duration_ms,
    SUM(CASE WHEN explicit IS NULL THEN 1 ELSE 0 END) AS null_explicit,
    SUM(CASE WHEN danceability IS NULL THEN 1 ELSE 0 END) AS null_danceability,
    SUM(CASE WHEN energy IS NULL THEN 1 ELSE 0 END) AS null_energy,
    SUM(CASE WHEN [key] IS NULL THEN 1 ELSE 0 END) AS null_key,
    SUM(CASE WHEN loudness IS NULL THEN 1 ELSE 0 END) AS null_loudness,
    SUM(CASE WHEN mode IS NULL THEN 1 ELSE 0 END) AS null_mode,
    SUM(CASE WHEN speechiness IS NULL THEN 1 ELSE 0 END) AS null_speechiness,
    SUM(CASE WHEN acousticness IS NULL THEN 1 ELSE 0 END) AS null_acousticness,
    SUM(CASE WHEN instrumentalness IS NULL THEN 1 ELSE 0 END) AS null_instrumentalness,
    SUM(CASE WHEN liveness IS NULL THEN 1 ELSE 0 END) AS null_liveness,
    SUM(CASE WHEN valence IS NULL THEN 1 ELSE 0 END) AS null_valence,
    SUM(CASE WHEN tempo IS NULL THEN 1 ELSE 0 END) AS null_tempo,
    SUM(CASE WHEN time_signature IS NULL THEN 1 ELSE 0 END) AS null_time_signature,
    SUM(CASE WHEN track_genre IS NULL THEN 1 ELSE 0 END) AS null_track_genre
FROM spotify;

SELECT *,
    (CASE WHEN artists IS NULL THEN 1 ELSE 0 END +
     CASE WHEN album_name IS NULL THEN 1 ELSE 0 END +
     CASE WHEN track_name IS NULL THEN 1 ELSE 0 END +
     CASE WHEN energy IS NULL THEN 1 ELSE 0 END +
     CASE WHEN loudness IS NULL THEN 1 ELSE 0 END +
     CASE WHEN acousticness IS NULL THEN 1 ELSE 0 END +
     CASE WHEN valence IS NULL THEN 1 ELSE 0 END
    ) AS null_count
FROM spotify
WHERE 
    (CASE WHEN artists IS NULL THEN 1 ELSE 0 END +
     CASE WHEN album_name IS NULL THEN 1 ELSE 0 END +
     CASE WHEN track_name IS NULL THEN 1 ELSE 0 END +
     CASE WHEN energy IS NULL THEN 1 ELSE 0 END +
     CASE WHEN loudness IS NULL THEN 1 ELSE 0 END +
     CASE WHEN acousticness IS NULL THEN 1 ELSE 0 END +
     CASE WHEN valence IS NULL THEN 1 ELSE 0 END
    ) > 1
ORDER BY null_count DESC;

SELECT COUNT(*) FROM spotify
WHERE artists IS NULL 
  AND album_name IS NULL 
  AND track_name IS NULL;

DELETE FROM spotify
WHERE artists IS NULL 
  AND album_name IS NULL 
  AND track_name IS NULL;

--checking for duplicates
SELECT track_id, artists, track_name, album_name, COUNT(*) AS occurrences
FROM spotify
GROUP BY track_id, artists, track_name, album_name
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;

SELECT artists, track_name, track_genre, COUNT(*) AS occurrences
FROM spotify
WHERE track_name = 'Layla'
GROUP BY artists, track_name, track_genre;

SELECT DISTINCT artists, track_name, album_name
FROM spotify;

SELECT track_id, artists, track_name, album_name, track_genre
FROM spotify
WHERE track_name = 'Layla' AND artists = 'Derek & The Dominos';

SELECT track_id, artists, track_name, album_name, track_genre
FROM spotify
WHERE artists = 'Derek & The Dominos' AND track_name = 'Layla'
ORDER BY track_genre;

--tackling the nulls
SELECT DISTINCT
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY energy) OVER() AS median_energy,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY loudness) OVER() AS median_loudness,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY acousticness) OVER() AS median_acousticness,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY valence) OVER() AS median_valence
FROM spotify;

UPDATE spotify SET energy = 0.685000002384186 WHERE energy IS NULL;
UPDATE spotify SET loudness = -7.00799989700317 WHERE loudness IS NULL;
UPDATE spotify SET acousticness = 0.192000000166893 WHERE acousticness IS NULL;
UPDATE spotify SET valence = 0.463999898664856 WHERE valence IS NULL;

SELECT
    SUM(CASE WHEN energy IS NULL THEN 1 ELSE 0 END) AS null_energy,
    SUM(CASE WHEN loudness IS NULL THEN 1 ELSE 0 END) AS null_loudness,
    SUM(CASE WHEN acousticness IS NULL THEN 1 ELSE 0 END) AS null_acousticness,
    SUM(CASE WHEN valence IS NULL THEN 1 ELSE 0 END) AS null_valence
FROM spotify;