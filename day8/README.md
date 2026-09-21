Day 7: annex1 (Item Master) Analysis
Dataset

Item master table from Sales_Data — 251 unique items across 6 categories, imported into SQL Server.

Summary

Analyzed the annex1 item catalog to understand category distribution, verify category-code consistency, and check for duplicate or near-duplicate item entries. Found a concentrated catalog dominated by three categories, and identified a recurring product-variant naming pattern.

Key Steps

Category Distribution

Flower/Leaf Vegetables, Edible Mushroom, and Capsicum together make up ~87% of all 251 items
Cabbage and Solanum are minor categories with only 5–10 items each
Item count per category ranges from 5 to 100 (avg ~41.8)

Category Code Consistency

Confirmed all Category_Codes are uniformly 27 characters
Verified each Category_Code maps to exactly one Category_Name — no mismatches

Duplicate & Near-Duplicate Check

Confirmed no true duplicate Item_Codes or exact-duplicate Item_Names
Found a recurring variant pattern in item names — e.g. "Xixia Black Mushroom (1)" vs "(2)", and "(Bag)"/"(Box)" suffixes — indicating the same base product often exists as multiple catalog entries by grade or packaging
