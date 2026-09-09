--CREATE DATABASE Titanic

SELECT*
FROM tested;yhh 

UPDATE tested 
SET Age = sub.avg_age
FROM tested t
JOIN(
	SELECT Pclass,
			Sex,
			AVG(Age) AS avg_age
	FROM tested
	WHERE Age IS NOT NULL
	GROUP BY Pclass, Sex
	) sub
ON t.Pclass= sub.Pclass
AND t.Sex= sub.Sex
WHERE t.Age IS NULL;

ALTER TABLE tested
ADD HasCabin INT;

UPDATE tested 
SET HasCabin = CASE WHEN Cabin IS NULL THEN 0 ELSE 1 END;

UPDATE tested
SET Fare =(
	SELECT AVG(Fare)
	FROM tested
	WHERE Pclass =3 AND Fare IS NOT NULL
	)
WHERE Pclass = 3 AND Fare IS NULL;