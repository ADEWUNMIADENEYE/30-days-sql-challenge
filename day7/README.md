**annex3 — Wholesale Price Analysis Findings**



Note: Item\_Code in annex3 is still stored as datetime2 (not re-imported like annex2/annex22). Findings below are still valid for comparing items against each other, but Item\_Code values are not human-readable and can't yet be joined to annex1 for real item names.



**1. Overall Price Range**

Min: ₦0.01/kg

Max: ₦141/kg

Avg: ₦6.10/kg



**Interpretation:** Wide spread, consistent with annex2's selling price range — expected across many different vegetable types. The ₦0.01 minimum is worth a quick sanity check, same as the ₦0.10 selling-price minimum flagged in annex2 — could be genuine or a data entry error.



**2. Monthly Average Price Trend (36 months)**

Peak: Jan 2021 (₦8.37), Feb 2021 (₦8.21)

Lowest: May 2021 (₦4.75), June 2021 (₦5.03)

Gradual recovery from mid-2021 lows through late 2021 into 2022



**Interpretation:** This overlaps directly with annex2's findings — wholesale prices dropped sharply in the same window (May–June 2021) that annex2 showed a revenue slump. This is a meaningful cross-table link: lower wholesale prices around that time likely reflect lower demand or market oversupply generally, which would explain both the cheaper cost side (annex3) and the weaker sales revenue (annex2) happening together.



**3. Price Volatility per Item**



Some items show extreme volatility — e.g., one item ranges ₦5 to ₦65.41 (stdev \~24.65) over just 6 records; another ranges ₦0.05 to ₦40.25 (stdev \~7.66) across 728 records.



**Interpretation:** Items with few records but huge price swings are less trustworthy — the volatility could be real, or just noise from too little data. Items with many records and still high volatility are more reliably "genuinely volatile" and worth flagging as high-risk/unpredictable-cost items for planning.



**4. Biggest Single-Day Price Jumps**



Massive swings appear — e.g., one item jumped from ₦5 to ₦112.36 (+₦69.24), then dropped from ₦112.36 to ₦34.43 (−₦77.93) shortly after.



**Interpretation:** These are extreme for wholesale food pricing — likely outliers/data errors rather than real market movement, unless genuine supply shocks of that scale occurred. Recommend flagging rows where ABS(price\_change) > avg\_price \* 3 for manual review before trusting them further.



**5. Data Completeness (records per item)**



Many items have only 1–3 price records across the entire dataset.



**Interpretation:** Items with only 1–3 records can't support meaningful trend or volatility analysis. Recommend setting a minimum threshold (e.g., 20+ records) before including an item in volatility or trend conclusions.



**Overall Takeaways**

Wholesale price dip in May–June 2021 lines up directly with the sales revenue dip found in annex2 — strong candidate for a shared root cause (market-wide oversupply or demand drop). Worth highlighting as a cross-table insight in the final report.

Price range is wide (₦0.01–₦141); the ₦0.01 minimum needs a data-quality check, same as annex2's ₦0.10 minimum.

High-volatility items should be filtered by record count first — sparse-data volatility isn't reliable.

Some price jumps are extreme enough to likely be errors, not real market moves — worth a filtering/review step before trusting volatility rankings.

Item\_Code is still unreadable (datetime2) — re-import annex3 the same way as annex2 if you want proper item names attached to these findings.

