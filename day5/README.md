Sales_Data — Dataset README
Overview

This dataset (Sales_Data) has four related tables — annex1, annex2, annex3, and annex4. They split into two pairs based on structure and purpose:

annex1 & annex4 — item-level reference tables (one row per item)
annex2 & annex3 — transaction/event-level tables (many rows per item)
annex1 & annex4 — Item Reference Tables

Both keyed on Item_Code, 251 rows each, zero nulls, zero duplicates. Item_Code is unique in both and set as the primary key in each.

annex1 — Item Master

Item_Code (PK) — unique product identifier
Item_Name — name of the item
Category_Code — code for the item's category
Category_Name — name of the category (e.g. "Flower/Leaf Vegetables")

annex4 — Loss Rate Reference

Item_Code (PK) — unique product identifier
Item_Name — name of the item
Loss_Rate — spoilage/shrinkage rate for the item

Why they're similar: both are lookup tables — one row per item, no repeats — used to enrich the transactional tables with item names, categories, and loss rates.

annex2 & annex3 — Transactional Tables

Both record repeated events over time for the same items, so Item_Code is not unique in either. Neither should use Item_Code as primary key — each needs a surrogate key instead.

annex2 — Sales Transactions (878,503 rows)

Date — 0 nulls
Time — 18,841 nulls (fine unless doing hour-level analysis)
Item_Code — 28,458 nulls (filter with WHERE Item_Code IS NOT NULL for item-level analysis)
Quantity_Sold_kilo — 461 nulls, all on Sale_or_Return = 'return' rows — expected, not an error
Unit_Selling_Price_RMB_kg — 0 nulls
Sale_or_Return — 0 nulls
Discount_Yes_No — 0 nulls
Checked for exact duplicates (all columns, excluding null-Time rows) — none found.

annex3 — Wholesale Price History (55,982 rows)

Date — 0 nulls
Item_Code — 2,001 nulls (~3.6%) — filter with WHERE Item_Code IS NOT NULL for item-level analysis
Wholesale_Price_RMB_kg — 0 nulls
Repeated Item_Code with different dates/prices is expected (price history), not duplication. Checked for exact duplicates — none found.

Why they're similar: both log repeated events per item over time (a sale, a price on a given day), so the same Item_Code legitimately appears many times. Both need a surrogate id INT IDENTITY(1,1) column as PK.

Data Cleaning Summary
No true duplicate rows found in any of the four tables.
Nulls in annex2 and annex3 are minor (under ~3.6%) and explained by legitimate business logic.
Primary keys set: annex1.Item_Code, annex4.Item_Code. Recommend surrogate PK for annex2/annex3.
Next Steps
Join annex2 (sales) with annex3 (wholesale price) on Date + Item_Code to calculate profit margins.
Join with annex1 for item names/categories and annex4 for loss-rate-adjusted figures.