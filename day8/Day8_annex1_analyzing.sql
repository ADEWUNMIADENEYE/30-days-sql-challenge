SELECT Category_Name, COUNT(*) AS item_count
FROM annex1
GROUP BY Category_Name
ORDER BY item_count DESC;

SELECT Category_Code, Category_Name, COUNT(*) AS item_count
FROM annex1
GROUP BY Category_Code, Category_Name
ORDER BY Category_Code;

SELECT Item_Name, COUNT(*) AS cnt
FROM annex1
GROUP BY Item_Name
HAVING COUNT(*) > 1;

SELECT COUNT(DISTINCT Category_Code) AS total_categories
FROM annex1;

SELECT MIN(item_count) AS min_items_per_category, 
       MAX(item_count) AS max_items_per_category,
       AVG(item_count * 1.0) AS avg_items_per_category
FROM (
    SELECT Category_Code, COUNT(*) AS item_count
    FROM annex1
    GROUP BY Category_Code
) t;

SELECT Item_Name, LEN(Item_Name) AS name_length
FROM annex1
ORDER BY name_length DESC;

SELECT Item_Name
FROM annex1
WHERE Item_Name LIKE '%[0-9]%' OR Item_Name LIKE '%(%' OR Item_Name LIKE '%)%';

SELECT Item_Name
FROM annex1
WHERE Item_Name != LTRIM(RTRIM(Item_Name));

SELECT DISTINCT Category_Code, LEN(Category_Code) AS code_length
FROM annex1
ORDER BY code_length;

SELECT LEFT(Item_Name, 1) AS first_letter, COUNT(*) AS cnt
FROM annex1
GROUP BY LEFT(Item_Name, 1)
ORDER BY cnt DESC;

SELECT a.Item_Name AS name1, b.Item_Name AS name2
FROM annex1 a
JOIN annex1 b ON a.Item_Code < b.Item_Code
WHERE a.Item_Name LIKE '%' + SUBSTRING(b.Item_Name, 1, 5) + '%'
   OR b.Item_Name LIKE '%' + SUBSTRING(a.Item_Name, 1, 5) + '%';