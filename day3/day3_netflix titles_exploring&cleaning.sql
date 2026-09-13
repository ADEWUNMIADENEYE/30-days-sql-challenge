--
SELECT*
FROM netflix_titles 

--Finding the total rows in the dataset
SELECT
	COUNT(*) AS Total
FROM netflix_titles 

--Identifying total NULLS in each column in the dataset
SELECT 'Show_ID' AS TOTAL_NULLS, COUNT(*) AS COUNT FROM netflix_titles WHERE show_id IS NULL
UNION ALL
SELECT 'Type', COUNT(*) FROM netflix_titles WHERE type IS NULL
UNION ALL
SELECT 'Title', COUNT(*) FROM netflix_titles WHERE title IS NULL
UNION ALL
SELECT 'Director', COUNT(*) FROM netflix_titles WHERE director IS NULL
UNION ALL
SELECT 'Cast', COUNT(*) FROM netflix_titles WHERE cast IS NULL
UNION ALL
SELECT 'Country', COUNT(*) FROM netflix_titles WHERE country IS NULL
UNION ALL
SELECT 'Date_added', COUNT(*) FROM netflix_titles WHERE date_added IS NULL
UNION ALL
SELECT 'Release_year', COUNT(*) FROM netflix_titles WHERE release_year IS NULL
UNION ALL
SELECT 'Rating', COUNT(*) FROM netflix_titles WHERE rating IS NULL
UNION ALL
SELECT 'Duration', COUNT(*) FROM netflix_titles WHERE duration IS NULL
UNION ALL
SELECT 'Listed_in', COUNT(*) FROM netflix_titles WHERE listed_in IS NULL
UNION ALL
SELECT 'Description', COUNT(*) FROM netflix_titles WHERE description IS NULL 

-- Replacing NULLS in director,cast and country with "Unknown"
UPDATE netflix_titles
SET director = 'Unknown'
WHERE director IS NULL

UPDATE netflix_titles
SET cast = 'Unknown'
WHERE cast IS NULL

UPDATE netflix_titles
SET country = 'Unknown'
WHERE country IS NULL 

--Replacing nulls in duration with the actual value found in rating
UPDATE netflix_titles
SET rating = 'Unknown' , duration = '74 min' , listed_in = 'Stand-up comedy'
WHERE show_id ='s5542' 

UPDATE netflix_titles
SET rating = 'Unknown' , duration = '84 min' , listed_in = 'Stand-up comedy'
WHERE show_id ='s5795'

UPDATE netflix_titles
SET rating = 'Unknown' , duration = '66 min' , listed_in = 'Stand-up comedy'
WHERE show_id ='s5814' 

--Fixing the actual rating for the nulls by searching online
UPDATE netflix_titles
SET rating = 'PG-13'
WHERE show_id = 's7538'

UPDATE netflix_titles
SET rating = 'TV-G or TV-Y'
WHERE show_id = 's7313'

UPDATE netflix_titles
SET rating = 'Unknown'
WHERE show_id = 's6828'

UPDATE netflix_titles
SET rating = 'Unknown'
WHERE show_id = 's5990'




