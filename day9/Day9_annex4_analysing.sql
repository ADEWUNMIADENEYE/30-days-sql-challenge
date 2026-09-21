SELECT 
    MIN(Loss_Rate) AS min_loss_rate,
    MAX(Loss_Rate) AS max_loss_rate,
    AVG(Loss_Rate) AS avg_loss_rate
FROM annex4;

SELECT 
    CASE 
        WHEN Loss_Rate < 5 THEN '0-5%'
        WHEN Loss_Rate < 10 THEN '5-10%'
        WHEN Loss_Rate < 15 THEN '10-15%'
        WHEN Loss_Rate < 20 THEN '15-20%'
        ELSE '20%+'
    END AS loss_rate_bucket,
    COUNT(*) AS item_count
FROM annex4
GROUP BY 
    CASE 
        WHEN Loss_Rate < 5 THEN '0-5%'
        WHEN Loss_Rate < 10 THEN '5-10%'
        WHEN Loss_Rate < 15 THEN '10-15%'
        WHEN Loss_Rate < 20 THEN '15-20%'
        ELSE '20%+'
    END
ORDER BY MIN(Loss_Rate);

SELECT TOP 15 Item_Name, Loss_Rate
FROM annex4
ORDER BY Loss_Rate DESC;

SELECT TOP 15 Item_Name, Loss_Rate
FROM annex4
ORDER BY Loss_Rate ASC;

SELECT i.Category_Name, 
       AVG(l.Loss_Rate) AS avg_loss_rate,
       MIN(l.Loss_Rate) AS min_loss_rate,
       MAX(l.Loss_Rate) AS max_loss_rate
FROM annex4 l
JOIN annex1 i ON l.Item_Code = i.Item_Code
GROUP BY i.Category_Name
ORDER BY avg_loss_rate DESC;