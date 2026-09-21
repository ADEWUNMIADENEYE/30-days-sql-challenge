SELECT*
FROM annex2

--EXPLORING AND CLEANING THE DATA
SELECT 
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS null_date,
    SUM(CASE WHEN Item_Code IS NULL THEN 1 ELSE 0 END) AS null_item_code,
    SUM(CASE WHEN Time IS NULL THEN 1 ELSE 0 END) AS null_time,
    SUM(CASE WHEN Quantity_Sold_kilo IS NULL THEN 1 ELSE 0 END) AS null_qty,
    SUM(CASE WHEN Unit_Selling_Price_RMB_kg IS NULL THEN 1 ELSE 0 END) AS null_price,
    SUM(CASE WHEN Sale_or_Return IS NULL THEN 1 ELSE 0 END) AS null_sale_return,
    SUM(CASE WHEN Discount_Yes_No IS NULL THEN 1 ELSE 0 END) AS null_discount,
    COUNT(*) AS total_rows
FROM annex2;

SELECT*
FROM annex2
WHERE Quantity_Sold_kilo IS NULL

SELECT Sale_or_Return, COUNT(*) AS cnt
FROM annex2
WHERE Quantity_Sold_kilo IS NULL
GROUP BY Sale_or_Return;

SELECT Date, Time, Item_Code, Quantity_Sold_kilo, Unit_Selling_Price_RMB_kg, Sale_or_Return, Discount_Yes_No, COUNT(*) AS cnt
FROM annex2
GROUP BY Date, Time, Item_Code, Quantity_Sold_kilo, Unit_Selling_Price_RMB_kg, Sale_or_Return, Discount_Yes_No
HAVING COUNT(*) > 1;

SELECT Date, Time, Item_Code, Quantity_Sold_kilo, Unit_Selling_Price_RMB_kg, Sale_or_Return, Discount_Yes_No, COUNT(*) AS cnt
FROM annex2
WHERE Time IS NOT NULL
GROUP BY Date, Time, Item_Code, Quantity_Sold_kilo, Unit_Selling_Price_RMB_kg, Sale_or_Return, Discount_Yes_No
HAVING COUNT(*) > 1

--
ALTER TABLE annex2
ADD id INT IDENTITY(1,1) NOT NULL;

ALTER TABLE annex2
ADD CONSTRAINT PK_annex2 PRIMARY KEY (id);

CREATE INDEX IX_annex2_ItemCode ON annex2 (Item_Code);