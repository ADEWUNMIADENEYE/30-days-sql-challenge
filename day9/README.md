Day 9: annex4 (Loss Rate) Analysis
Dataset

Loss rate reference table from Sales_Data — 251 items, imported into SQL Server.

Summary

Analyzed spoilage/shrinkage rates across the item catalog, identified highest and lowest risk items, and joined with annex1 to find which vegetable categories are most prone to loss.

Key Steps

Overall Loss Rate Range

Min: 0%, Max: 29.25%, Avg: ~9.43%
Most items (131 of 251, ~52%) fall in the 5–10% loss range — the "normal" band
A smaller group (29 items, ~11.5%) sits above 15% loss — meaningfully higher risk
8 items exceed 20% loss — the highest-risk tier

Highest Loss Rate Items

Top of the list: High Melon (1) at 29.25%, followed by Chuncai, Dongmenkou Xiaobaicai, and Foreign Garland Chrysanthemum — all above 25%
These are the items most likely to spoil before sale and worth prioritizing for faster turnover, smaller batch ordering, or targeted discounting

Lowest Loss Rate Items

Multiple items sit at exactly 0% loss — e.g. Green Hangjiao (1), Lameizi, Purple Screw Pepper, several boxed/bagged items
Worth a light sanity check: a true 0% loss rate is unusual for fresh produce — could be genuine (well-preserved/packaged items) or a data gap where loss simply wasn't recorded

Loss Rate by Category (joined with annex1)

Cabbage has the highest average loss rate (14.14%), despite being the smallest category by item count
Aquatic Tuberous Vegetables and Flower/Leaf Vegetables follow (~10–12% avg)
Solanum has the lowest average loss rate (7.12%)
This is a genuinely useful cross-table insight: Cabbage is disproportionately high-risk for spoilage relative to its small catalog size, while the largest category (Flower/Leaf Vegetables) sits closer to the middle of the pack
