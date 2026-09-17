--Analysing the data
SELECT*
FROM netflix_titles

SELECT*
FROM netflix_titles
WHERE type = 'Movie'

SELECT*
FROM netflix_titles
WHERE type = 'TV Show' 

--Finding the total contents by country 
SELECT 'US' AS Country, COUNT(*) AS Total_Occurence FROM netflix_titles WHERE country = 'United States'
UNION ALL
SELECT 'UK', COUNT(*) FROM netflix_titles WHERE country = 'United Kingdom'
UNION ALL
SELECT 'India', COUNT(*) FROM netflix_titles WHERE country = 'India'
UNION ALL
SELECT 'Italy', COUNT(*) FROM netflix_titles WHERE country = 'Italy'
UNION ALL
SELECT 'Australia', COUNT(*) FROM netflix_titles WHERE country = 'Australia'
UNION ALL
SELECT 'Egypt', COUNT(*) FROM netflix_titles WHERE country = 'Egypt'
UNION ALL
SELECT 'Thailand', COUNT(*) FROM netflix_titles WHERE country = 'Thailand'
UNION ALL
SELECT 'Argentina', COUNT(*) FROM netflix_titles WHERE country = 'Argentina'
UNION ALL
SELECT 'Mauritius', COUNT(*) FROM netflix_titles WHERE country = 'Mauritius'
UNION ALL
SELECT 'Canada', COUNT(*) FROM netflix_titles WHERE country = 'Canada'
UNION ALL
SELECT 'Spain', COUNT(*) FROM netflix_titles WHERE country = 'Spain'
UNION ALL
SELECT 'Unknown country', COUNT(*) FROM netflix_titles WHERE country = 'Unknown'
UNION ALL
SELECT 'Israel', COUNT(*) FROM netflix_titles WHERE country = 'Israel'
UNION ALL
SELECT 'Japan', COUNT(*) FROM netflix_titles WHERE country = 'Japan'
UNION ALL
SELECT 'Lebanon', COUNT(*) FROM netflix_titles WHERE country = 'Lebanon'
UNION ALL
SELECT 'Turkey', COUNT(*) FROM netflix_titles WHERE country = 'Turkey'
UNION ALL
SELECT 'Mexico', COUNT(*) FROM netflix_titles WHERE country = 'Mexico'
UNION ALL
SELECT 'South Korea', COUNT(*) FROM netflix_titles WHERE country = 'South Korea'
UNION ALL
SELECT 'China', COUNT(*) FROM netflix_titles WHERE country = 'China'
UNION ALL
SELECT 'Belgium', COUNT(*) FROM netflix_titles WHERE country = 'Belgium'
UNION ALL
SELECT 'France', COUNT(*) FROM netflix_titles WHERE country = 'France'
UNION ALL
SELECT 'Luxembourg', COUNT(*) FROM netflix_titles WHERE country = 'Luxembourg'
UNION ALL
SELECT 'Brazil', COUNT(*) FROM netflix_titles WHERE country = 'Brazil'
UNION ALL
SELECT 'Colombia', COUNT(*) FROM netflix_titles WHERE country = 'Colombia'
UNION ALL
SELECT 'Philippines', COUNT(*) FROM netflix_titles WHERE country = 'Philippines'
UNION ALL
SELECT 'Senegal', COUNT(*) FROM netflix_titles WHERE country = 'Senegal'
UNION ALL
SELECT 'Norway', COUNT(*) FROM netflix_titles WHERE country = 'Norway'
UNION ALL
SELECT 'South Africa', COUNT(*) FROM netflix_titles WHERE country = 'South Africa'
UNION ALL
SELECT 'Saudi Arabia', COUNT(*) FROM netflix_titles WHERE country = 'Saudi Arabia'
UNION ALL
SELECT 'Multiple countries', COUNT(*) FROM netflix_titles WHERE country LIKE '%,%' 
UNION ALL
SELECT 'Denmark', COUNT(*) FROM netflix_titles WHERE country = 'Denmark'
UNION ALL
SELECT 'Austria', COUNT(*) FROM netflix_titles WHERE country = 'Austria'
UNION ALL
SELECT 'Nigeria', COUNT(*) FROM netflix_titles WHERE country = 'Nigeria'
UNION ALL
SELECT 'Hungary', COUNT(*) FROM netflix_titles WHERE country = 'Hungary'
UNION ALL
SELECT 'Germany', COUNT(*) FROM netflix_titles WHERE country = 'Germany'
UNION ALL
SELECT 'Taiwan', COUNT(*) FROM netflix_titles WHERE country = 'Taiwan'
UNION ALL
SELECT 'Netherlands', COUNT(*) FROM netflix_titles WHERE country = 'Netherlands'
UNION ALL
SELECT 'UAE', COUNT(*) FROM netflix_titles WHERE country = 'United Arab Emirates'
UNION ALL
SELECT 'Kuwait', COUNT(*) FROM netflix_titles WHERE country = 'Kuwait'
UNION ALL
SELECT 'Indonesia', COUNT(*) FROM netflix_titles WHERE country = 'Indonesia'
UNION ALL
SELECT 'Cameroon', COUNT(*) FROM netflix_titles WHERE country = 'Cameroon'
UNION ALL
SELECT 'Malaysia', COUNT(*) FROM netflix_titles WHERE country = 'Malaysia'
UNION ALL
SELECT 'Singapore', COUNT(*) FROM netflix_titles WHERE country = 'Singapore'
UNION ALL
SELECT 'Kenya', COUNT(*) FROM netflix_titles WHERE country = 'Kenya'
UNION ALL
SELECT 'New Zealand', COUNT(*) FROM netflix_titles WHERE country = 'New Zealand'
UNION ALL
SELECT 'Russia', COUNT(*) FROM netflix_titles WHERE country = 'Russia'
UNION ALL
SELECT 'Pakistan', COUNT(*) FROM netflix_titles WHERE country = 'Pakistan'
UNION ALL
SELECT 'Bangladesh', COUNT(*) FROM netflix_titles WHERE country = 'Bangladesh'
UNION ALL
SELECT 'Croatia', COUNT(*) FROM netflix_titles WHERE country = 'Croatia'
UNION ALL
SELECT 'West Germany', COUNT(*) FROM netflix_titles WHERE country = 'West Germany'
UNION ALL
SELECT 'Ireland', COUNT(*) FROM netflix_titles WHERE country = 'Ireland'
UNION ALL
SELECT 'Hong Kong', COUNT(*) FROM netflix_titles WHERE country = 'Hong Kong'
UNION ALL
SELECT 'Chile', COUNT(*) FROM netflix_titles WHERE country = 'Chile'
UNION ALL
SELECT 'Vietnam', COUNT(*) FROM netflix_titles WHERE country = 'Vietnam'
UNION ALL
SELECT 'Ghana', COUNT(*) FROM netflix_titles WHERE country = 'Ghana'
UNION ALL
SELECT 'Poland', COUNT(*) FROM netflix_titles WHERE country = 'Poland'
UNION ALL
SELECT 'Sweden', COUNT(*) FROM netflix_titles WHERE country = 'Sweden'
UNION ALL
SELECT 'Namibia', COUNT(*) FROM netflix_titles WHERE country = 'Namibia'
UNION ALL
SELECT 'Peru', COUNT(*) FROM netflix_titles WHERE country = 'Peru'
UNION ALL
SELECT 'Jordan', COUNT(*) FROM netflix_titles WHERE country = 'Jordan'
UNION ALL
SELECT 'Uruguay', COUNT(*) FROM netflix_titles WHERE country = 'Uruguay'
UNION ALL
SELECT 'Belarus', COUNT(*) FROM netflix_titles WHERE country = 'Belarus'
UNION ALL
SELECT 'Bulgaria', COUNT(*) FROM netflix_titles WHERE country = 'Bulgaria'
UNION ALL
SELECT 'Finland', COUNT(*) FROM netflix_titles WHERE country = 'Finland'
UNION ALL
SELECT 'Georgia', COUNT(*) FROM netflix_titles WHERE country = 'Georgia'
UNION ALL
SELECT 'Guatemala', COUNT(*) FROM netflix_titles WHERE country = 'Guatemala'
UNION ALL
SELECT 'Iceland', COUNT(*) FROM netflix_titles WHERE country = 'Iceland'
UNION ALL
SELECT 'Mozambique', COUNT(*) FROM netflix_titles WHERE country = 'Mozambique'
UNION ALL
SELECT 'Romania', COUNT(*) FROM netflix_titles WHERE country = 'Romania'
UNION ALL
SELECT 'Switzerland', COUNT(*) FROM netflix_titles WHERE country = 'Switzerland'
UNION ALL
SELECT 'Venezuela', COUNT(*) FROM netflix_titles WHERE country = 'Venezuela'
UNION ALL
SELECT 'Zimbabwe', COUNT(*) FROM netflix_titles WHERE country = 'Zimbabwe'
UNION ALL
SELECT 'Ukraine', COUNT(*) FROM netflix_titles WHERE country = 'Ukraine'
UNION ALL
SELECT 'Cambodia', COUNT(*) FROM netflix_titles WHERE country = 'Cambodia' 
UNION ALL
SELECT 'Cyprus', COUNT(*) FROM netflix_titles WHERE country = 'Cyprus'

--
SELECT
	title,
	country
FROM netflix_titles
ORDER BY country

SELECT
	country
FROM netflix_titles
WHERE country LIKE '%,%'
ORDER BY country


SELECT  country, COUNT(*) AS occurrence_count
FROM netflix_titles
WHERE country NOT LIKE '%,%'
GROUP BY country
HAVING COUNT(*) = 1
ORDER BY country 
--

--Finding the total content by type
SELECT 'Movie' AS Type, COUNT(*) AS Total_Occurence FROM netflix_titles WHERE type = 'Movie'
UNION ALL
SELECT 'Tv show', COUNT(*) FROM netflix_titles WHERE type = 'Tv show'

--Finding the total content by year released and movie type
SELECT '2021' AS Year, COUNT(*) AS Total_Movie_Released FROM netflix_titles WHERE type = 'Movie' AND release_year = 2021
UNION ALL
SELECT '2020', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2020
UNION ALL
SELECT '2019', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2019
UNION ALL
SELECT '2018', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2018
UNION ALL
SELECT '2017', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2017
UNION ALL
SELECT '2016', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2016
UNION ALL
SELECT '2015', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2015
UNION ALL
SELECT '2014', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2014
UNION ALL
SELECT '2013', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2013
UNION ALL
SELECT '2012', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2012
UNION ALL
SELECT '2011', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2011
UNION ALL
SELECT '2010', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2010
UNION ALL
SELECT '2009', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2009
UNION ALL
SELECT '2008', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2008
UNION ALL
SELECT '2007', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2007
UNION ALL
SELECT '2006', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2006
UNION ALL
SELECT '2005', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2005
UNION ALL
SELECT '2004', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2004
UNION ALL
SELECT '2003', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2003
UNION ALL
SELECT '2002', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2002
UNION ALL
SELECT '2001', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2001
UNION ALL
SELECT '2000', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 2000
UNION ALL
SELECT '1999', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1999
UNION ALL
SELECT '1998', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1998
UNION ALL
SELECT '1997', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1997
UNION ALL
SELECT '1996', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1996
UNION ALL
SELECT '1995', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1995
UNION ALL
SELECT '1994', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1994
UNION ALL
SELECT '1993', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1993
UNION ALL
SELECT '1992', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1992
UNION ALL
SELECT '1991', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1991
UNION ALL
SELECT '1990', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1990
UNION ALL
SELECT '1989', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1989
UNION ALL
SELECT '1988', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1988
UNION ALL
SELECT '1987', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1987
UNION ALL
SELECT '1986', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1986
UNION ALL
SELECT '1985', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1985
UNION ALL
SELECT '1984', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1984
UNION ALL
SELECT '1983', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1983
UNION ALL
SELECT '1982', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1982
UNION ALL
SELECT '1981', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1981
UNION ALL
SELECT '1980', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1980
UNION ALL
SELECT '1979', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1979
UNION ALL
SELECT '1978', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1978
UNION ALL
SELECT '1977', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1977
UNION ALL
SELECT '1976', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1976
UNION ALL
SELECT '1975', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1975
UNION ALL
SELECT '1974', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1974
UNION ALL
SELECT '1973', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1973
UNION ALL
SELECT '1972', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1972
UNION ALL
SELECT '1971', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1971
UNION ALL
SELECT '1970', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1970
UNION ALL
SELECT '1969', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1969
UNION ALL
SELECT '1968', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1968
UNION ALL
SELECT '1967', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1967
UNION ALL
SELECT '1966', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1966
UNION ALL
SELECT '1965', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1965
UNION ALL
SELECT '1964', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1964
UNION ALL
SELECT '1963', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1963
UNION ALL
SELECT '1962', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1962
UNION ALL
SELECT '1961', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1961
UNION ALL
SELECT '1960', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1960
UNION ALL
SELECT '1959', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1959
UNION ALL
SELECT '1958', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1958
UNION ALL
SELECT '1956', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1956
UNION ALL
SELECT '1955', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1955
UNION ALL
SELECT '1954', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1954
UNION ALL
SELECT '1947', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1947
UNION ALL
SELECT '1946', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1946
UNION ALL
SELECT '1945', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1945
UNION ALL
SELECT '1944', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1944
UNION ALL
SELECT '1943', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1943
UNION ALL
SELECT '1942', COUNT(*) FROM netflix_titles WHERE type = 'Movie' AND release_year = 1942



--Finding the total content by year released and TV show type
SELECT '2021' AS Year, COUNT(*) AS Total_TVShow_Released FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2021
UNION ALL
SELECT '2020', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2020
UNION ALL
SELECT '2019', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2019
UNION ALL
SELECT '2018', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2018
UNION ALL
SELECT '2017', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2017
UNION ALL
SELECT '2016', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2016
UNION ALL
SELECT '2015', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2015
UNION ALL
SELECT '2014', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2014
UNION ALL
SELECT '2013', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2013
UNION ALL
SELECT '2012', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2012
UNION ALL
SELECT '2011', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2011
UNION ALL
SELECT '2010', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2010
UNION ALL
SELECT '2009', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2009
UNION ALL
SELECT '2008', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2008
UNION ALL
SELECT '2007', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2007
UNION ALL
SELECT '2006', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2006
UNION ALL
SELECT '2005', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2005
UNION ALL
SELECT '2004', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2004
UNION ALL
SELECT '2003', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2003
UNION ALL
SELECT '2002', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2002
UNION ALL
SELECT '2001', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2001
UNION ALL
SELECT '2000', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 2000
UNION ALL
SELECT '1999', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1999
UNION ALL
SELECT '1998', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1998
UNION ALL
SELECT '1997', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1997
UNION ALL
SELECT '1996', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1996
UNION ALL
SELECT '1995', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1995
UNION ALL
SELECT '1994', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1994
UNION ALL
SELECT '1993', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1993
UNION ALL
SELECT '1992', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1992
UNION ALL
SELECT '1991', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1991
UNION ALL
SELECT '1990', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1990
UNION ALL
SELECT '1989', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1989
UNION ALL
SELECT '1988', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1988
UNION ALL
SELECT '1986', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1986
UNION ALL
SELECT '1985', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1985
UNION ALL
SELECT '1981', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1981
UNION ALL
SELECT '1979', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1979
UNION ALL
SELECT '1977', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1977
UNION ALL
SELECT '1974', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1974
UNION ALL
SELECT '1972', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1972
UNION ALL
SELECT '1967', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1967
UNION ALL
SELECT '1963', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1963
UNION ALL
SELECT '1946', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1946
UNION ALL
SELECT '1945', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1945
UNION ALL
SELECT '1925', COUNT(*) FROM netflix_titles WHERE type = 'TV Show' AND release_year = 1925



SELECT
	type,
	release_year
FROM netflix_titles
ORDER BY release_year DESC


--Finding total content by rating
SELECT 'tv-14' AS Rating, COUNT(*) AS Total FROM netflix_titles WHERE rating = 'TV-14'
UNION ALL
SELECT 'tv-ma', COUNT(*) FROM netflix_titles WHERE rating = 'TV-MA'
UNION ALL
SELECT 'tv-y7', COUNT(*) FROM netflix_titles WHERE rating = 'TV-Y7'
UNION ALL
SELECT 'pg', COUNT(*) FROM netflix_titles WHERE rating = 'PG'
UNION ALL
SELECT 'pg-13', COUNT(*) FROM netflix_titles WHERE rating = 'PG-13'
UNION ALL
SELECT 'r', COUNT(*) FROM netflix_titles WHERE rating = 'R'
UNION ALL
SELECT 'tv-g', COUNT(*) FROM netflix_titles WHERE rating = 'TV-G'
UNION ALL
SELECT 'tv-pg', COUNT(*) FROM netflix_titles WHERE rating = 'TV-PG'
UNION ALL
SELECT 'nr', COUNT(*) FROM netflix_titles WHERE rating = 'NR'
UNION ALL
SELECT 'tv-y', COUNT(*) FROM netflix_titles WHERE rating = 'TV-Y'
UNION ALL
SELECT 'g', COUNT(*) FROM netflix_titles WHERE rating = 'G'
UNION ALL
SELECT 'nc-17', COUNT(*) FROM netflix_titles WHERE rating = 'NC-17'
UNION ALL
SELECT 'tv-gortv-y', COUNT(*) FROM netflix_titles WHERE rating = 'TV-G or TV-Y'
UNION ALL
SELECT 'tv-y7-fv', COUNT(*) FROM netflix_titles WHERE rating = 'TV-Y7-FV'
UNION ALL
SELECT 'ur', COUNT(*) FROM netflix_titles WHERE rating = 'UR'
UNION ALL
SELECT 'unknown', COUNT(*) FROM netflix_titles WHERE rating = 'Unknown'


SELECT
	rating
FROM netflix_titles
WHERE rating NOT LIKE '%,%'
ORDER BY rating 

--Finding the total movie added in a year
SELECT '2021' AS Year_added_to_netflix, COUNT(*) AS Total_content FROM netflix_titles WHERE date_added LIKE '2021%%'
UNION ALL
SELECT '2020', COUNT(*) FROM netflix_titles WHERE date_added LIKE '2020%%'
UNION ALL
SELECT '2019', COUNT(*) FROM netflix_titles WHERE date_added LIKE '2019%%'
UNION ALL
SELECT '2018', COUNT(*) FROM netflix_titles WHERE date_added LIKE '2018%%'
UNION ALL
SELECT '2017', COUNT(*) FROM netflix_titles WHERE date_added LIKE '2017%%'
UNION ALL
SELECT '2016', COUNT(*) FROM netflix_titles WHERE date_added LIKE '2016%%'
UNION ALL
SELECT '2015', COUNT(*) FROM netflix_titles WHERE date_added LIKE '2015%%'
UNION ALL
SELECT '2014', COUNT(*) FROM netflix_titles WHERE date_added LIKE '2014%%'
UNION ALL
SELECT '2013', COUNT(*) FROM netflix_titles WHERE date_added LIKE '2013%%'
UNION ALL
SELECT '2012', COUNT(*) FROM netflix_titles WHERE date_added LIKE '2012%%'
UNION ALL
SELECT '2011', COUNT(*) FROM netflix_titles WHERE date_added LIKE '2011%%'
UNION ALL
SELECT '2010', COUNT(*) FROM netflix_titles WHERE date_added LIKE '2010%%'
UNION ALL
SELECT '2009', COUNT(*) FROM netflix_titles WHERE date_added LIKE '2009%%'
UNION ALL
SELECT '2008', COUNT(*) FROM netflix_titles WHERE date_added LIKE '2008%%'
UNION ALL
SELECT 'NULL', COUNT(*) FROM netflix_titles WHERE date_added IS NULL
















