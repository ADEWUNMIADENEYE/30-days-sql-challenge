
--Show all datas
SELECT*
FROM tested

--
SELECT
	COUNT(*) AS t_passengers,
	SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS t_survived,
	SUM(CASE WHEN Survived = 0 THEN 1 ELSE 0 END) AS t_deceased,
	SUM(CASE WHEN Pclass = 1 THEN 1 ELSE 0 END) AS t_class1,
	SUM(CASE WHEN Pclass = 2 THEN 1 ELSE 0 END) AS t_class2,
	SUM(CASE WHEN Pclass = 3 THEN 1 ELSE 0 END) AS t_class3,
	SUM(CASE WHEN Sex = 'male' THEN 1 ELSE 0 END) AS t_male,
	SUM(CASE WHEN Sex = 'female' THEN 1 ELSE 0 END) AS t_female,
	SUM(CASE WHEN Pclass = 2 THEN 1 ELSE 0 END) AS t_class2,
	SUM(CASE WHEN HasCabin = 0 THEN 1 ELSE 0 END) AS missingCabinRecord
FROM tested 

--
SELECT 'Total Passengers' AS METRIC, COUNT(*) AS Count FROM tested
UNION ALL
SELECT 'Survived', COUNT(*) FROM tested WHERE Survived = 1
UNION ALL
SELECT 'Deceased', COUNT(*) FROM tested WHERE Survived = 0
UNION ALL
SELECT 'First Class', COUNT(*) FROM tested WHERE Pclass = 1
UNION ALL
SELECT 'Second Class', COUNT(*) FROM tested WHERE Pclass = 2
UNION ALL
SELECT 'Third Class', COUNT(*) FROM tested WHERE Pclass = 3
UNION ALL
SELECT 'Male', COUNT(*) FROM tested WHERE Sex = 'male'
UNION ALL
SELECT 'Female', COUNT(*) FROM tested WHERE Sex = 'female'
UNION ALL
SELECT 'MissingCabinRecord', COUNT(*) FROM tested WHERE HasCabin = 0 
UNION ALL
SELECT 'Children', COUNT(*) FROM tested WHERE Age < 13
UNION ALL
SELECT 'Teenagers' , COUNT(*) FROM tested WHERE Age>= 13 AND Age <20
UNION ALL
SELECT 'Adult' , COUNT(*) FROM tested WHERE Age >=20 AND Age <60
UNION ALL
SELECT 'Old aged' , COUNT(*) FROM tested WHERE Age >=60
UNION ALL
SELECT 'AVGFarePrice1',
	AVG(Fare) 
FROM tested
WHERE Pclass=1
UNION ALL
SELECT 'AVGFarePrice2',
	AVG(Fare) 
FROM tested
WHERE Pclass=2
UNION ALL
SELECT 'AVGFarePrice3',
	AVG(Fare) 
FROM tested
WHERE Pclass=3

--Analysing survival rate by class,gender,and age group
SELECT 'Firstclass1' AS SURVIVED, COUNT(*) AS COUNT 
FROM tested
WHERE Survived=1 
AND Pclass=1
UNION ALL
SELECT 'Secondclass2' , COUNT(*)
FROM tested
WHERE Survived=1 
AND Pclass=2
UNION ALL
SELECT 'Thirdclass3', COUNT(*)
FROM tested
WHERE Survived=1 
AND Pclass=3
UNION ALL
SELECT 'Male', COUNT(*)
FROM tested
WHERE Survived=1 
AND Sex='male'
UNION ALL
SELECT 'Female', COUNT(*)
FROM tested
WHERE Survived=1 
AND Sex='female'
UNION ALL
SELECT 'Children', COUNT(*)
FROM tested
WHERE Survived=1 
AND Age<13 
UNION ALL
SELECT 'Teenagers', COUNT(*)
FROM tested
WHERE Survived=1 
AND Age >= 13 AND Age<20
UNION ALL
SELECT 'Adult', COUNT(*)
FROM tested
WHERE Survived=1 
AND Age>=20 AND Age<60
UNION ALL
SELECT 'Old Aged', COUNT(*)
FROM tested
WHERE Survived=1 
AND Age>60


