SELECT COUNT(*) AS customers,
       ROUND(AVG(CAST(Output AS FLOAT)) * 100, 1) AS output_pct,
       ROUND(AVG(CASE WHEN Feedback = 'Positive' THEN 1.0 ELSE 0 END) * 100, 1) AS positive_feedback_pct,
       ROUND(AVG(CAST(Age AS FLOAT)), 1) AS avg_age
FROM online_food_clean;

--Output rate by income
SELECT Income_Order, Monthly_Income,
       COUNT(*) AS customers,
       ROUND(AVG(CAST(Output AS FLOAT)) * 100, 1) AS output_pct
FROM online_food_clean
GROUP BY Income_Order, Monthly_Income
ORDER BY Income_Order;


--Output rate by occupation
SELECT Occupation,
       COUNT(*) AS customers,
       ROUND(AVG(CAST(Output AS FLOAT)) * 100, 1) AS output_pct
FROM online_food_clean
GROUP BY Occupation
ORDER BY customers DESC;

SELECT Occupation, Income_Order, Monthly_Income,
       COUNT(*) AS customers,
       ROUND(AVG(CAST(Output AS FLOAT)) * 100, 1) AS output_pct
FROM online_food_clean
GROUP BY Occupation, Income_Order, Monthly_Income
ORDER BY Occupation, Income_Order;


--Customer type by output
SELECT Customer_Type,
       COUNT(*) AS customers,
       ROUND(AVG(CAST(Output AS FLOAT)) * 100, 1) AS output_pct,
       ROUND(AVG(CASE WHEN Feedback = 'Positive' THEN 1.0 ELSE 0 END) * 100, 1) AS positive_pct
FROM online_food_clean
GROUP BY Customer_Type
ORDER BY customers DESC;

SELECT Output, Feedback, COUNT(*) AS customers
FROM online_food_clean
GROUP BY Output, Feedback
ORDER BY Output DESC, Feedback;

SELECT CASE WHEN Age < 22 THEN 'Under 22'
            WHEN Age BETWEEN 22 AND 24 THEN '22-24'
            WHEN Age BETWEEN 25 AND 27 THEN '25-27'
            ELSE '28+' END AS age_band,
       COUNT(*) AS customers,
       ROUND(AVG(CAST(Output AS FLOAT)) * 100, 1) AS output_pct
FROM online_food_clean
GROUP BY CASE WHEN Age < 22 THEN 'Under 22'
              WHEN Age BETWEEN 22 AND 24 THEN '22-24'
              WHEN Age BETWEEN 25 AND 27 THEN '25-27'
              ELSE '28+' END
ORDER BY MIN(Age);

SELECT CASE WHEN Age < 25 THEN 'Under 25' ELSE '25+' END AS age_group,
       Occupation,
       COUNT(*) AS customers,
       ROUND(AVG(CAST(Output AS FLOAT)) * 100, 1) AS output_pct
FROM online_food_clean
GROUP BY CASE WHEN Age < 25 THEN 'Under 25' ELSE '25+' END, Occupation
ORDER BY age_group, Occupation;

SELECT CASE WHEN Age < 25 THEN 'Under 25' ELSE '25+' END AS age_group,
       Marital_Status,
       COUNT(*) AS customers,
       ROUND(AVG(CAST(Output AS FLOAT)) * 100, 1) AS output_pct
FROM online_food_clean
WHERE Occupation = 'Employee'
GROUP BY CASE WHEN Age < 25 THEN 'Under 25' ELSE '25+' END, Marital_Status
ORDER BY age_group, Marital_Status;

--Analysis on family size
SELECT Family_size,
       COUNT(*) AS customers,
       ROUND(AVG(CAST(Output AS FLOAT)) * 100, 1) AS output_pct
FROM online_food_clean
GROUP BY Family_size
ORDER BY Family_size;

SELECT CASE WHEN Family_size <= 3 THEN '1-3'
            WHEN Family_size <= 5 THEN '4-5'
            ELSE '6' END AS family_group,
       Occupation,
       COUNT(*) AS customers,
       ROUND(AVG(CAST(Output AS FLOAT)) * 100, 1) AS output_pct
FROM online_food_clean
GROUP BY CASE WHEN Family_size <= 3 THEN '1-3'
              WHEN Family_size <= 5 THEN '4-5'
              ELSE '6' END, Occupation
ORDER BY family_group, Occupation;

SELECT CASE WHEN Educational_Qualifications IN ('School', 'Uneducated')
            THEN 'School or below'
            ELSE Educational_Qualifications END AS education,
       COUNT(*) AS customers,
       ROUND(AVG(CAST(Output AS FLOAT)) * 100, 1) AS output_pct
FROM online_food_clean
GROUP BY CASE WHEN Educational_Qualifications IN ('School', 'Uneducated')
              THEN 'School or below'
              ELSE Educational_Qualifications END
ORDER BY customers DESC;

SELECT Occupation,
       Educational_Qualifications AS education,
       COUNT(*) AS customers,
       ROUND(AVG(CAST(Output AS FLOAT)) * 100, 1) AS output_pct
FROM online_food_clean
WHERE Educational_Qualifications IN ('Graduate', 'Post Graduate')
  AND Occupation IN ('Student', 'Employee', 'Self Employed')
GROUP BY Occupation, Educational_Qualifications
ORDER BY Occupation, Educational_Qualifications;

SELECT Occupation, LEN(Occupation) AS len, COUNT(*) AS n
FROM online_food_clean
GROUP BY Occupation;

--Fixing the wrongly spelt "self employed"
UPDATE online_food_clean
SET Occupation = 'Self Employed'
WHERE Occupation = 'Self Employeed';

SELECT Occupation, LEN(Occupation) AS len, COUNT(*) AS n
FROM online_food_clean
GROUP BY Occupation;

SELECT Occupation,
       Educational_Qualifications AS education,
       COUNT(*) AS customers,
       ROUND(AVG(CAST(Output AS FLOAT)) * 100, 1) AS output_pct
FROM online_food_clean
WHERE Educational_Qualifications IN ('Graduate', 'Post Graduate')
  AND Occupation <> 'House wife'
GROUP BY Occupation, Educational_Qualifications
ORDER BY Occupation, Educational_Qualifications;

--Analysing gender
SELECT Gender, Occupation,
       COUNT(*) AS customers,
       ROUND(AVG(CAST(Output AS FLOAT)) * 100, 1) AS output_pct
FROM online_food_clean
WHERE Occupation <> 'House wife'
GROUP BY Gender, Occupation
ORDER BY Occupation, Gender;

SELECT Pin_code,
       COUNT(*) AS customers,
       ROUND(AVG(CAST(Output AS FLOAT)) * 100, 1) AS output_pct
FROM online_food_clean
GROUP BY Pin_code
HAVING COUNT(*) >= 10
ORDER BY customers DESC;