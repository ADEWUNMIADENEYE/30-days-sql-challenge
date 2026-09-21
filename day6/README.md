**annex2 — Sales Analysis Findings**

**1. Daily Revenue Trend (July 2020 sample)**



Daily revenue ranged roughly ₦3,200–₦6,070 early on, trending upward by mid-July (July 19 peaked at ₦6,071).

Interpretation: Revenue isn't flat even within a few weeks — worth checking if this holds across the full dataset.



**2. Monthly Revenue Trend (36 months)**

Highest: Feb 2021 (₦178,876)

Lowest: Nov 2021 (₦57,732)

Clear dip mid-to-late 2021, recovery into 2022.



Interpretation: Revenue is seasonal, not steady. The 2021 slump is worth investigating further (market conditions, supply issues, etc.).



**3. Day-of-Week Performance**

Day	Transactions	Total Qty	Total Revenue	Avg Price

Saturday	158,891	85,791.60	₦609,718.84	₦8.87

Sunday	155,541	82,754.79	₦597,122.59	₦8.96

Friday	120,944	66,205.72	₦471,285.74	₦8.85

Wednesday	111,950	59,400.83	₦435,787.09	₦9.16

Monday	112,892	60,485.88	₦425,469.85	₦8.78

Tuesday	109,648	58,288.11	₦419,046.96	₦8.95

Thursday	108,226	58,348.91	₦413,592.28	₦8.85



Interpretation: Weekends (Sat/Sun) clearly dominate — both in transaction count and total revenue, roughly 30–40% higher than weekdays. Avg price per kg stays fairly consistent across all days (₦8.78–₦9.16), so the weekend boost is driven by volume/footfall, not pricing. Useful for staffing and restocking — weekends need the most inventory ready.



**4. Return Rate**

Overall: 461 returns out of 878,503 transactions (0.05%)

Monthly return rate has stayed consistently low (mostly 0.00003–0.004), with a notable spike in Oct 2021 (86 returns, 0.0038 rate) and Sept 2021 (42 returns) — both well above the typical range.



Interpretation: Returns are a non-issue overall, but the Sept–Oct 2021 spike lines up with the same period flagged in the monthly revenue dip (§2). Worth checking if something specific happened around then (bad batch, quality issue, supplier change) — the timing overlap between low revenue and elevated returns is suspicious enough to investigate together, not separately.



⚠️ Top returned items (Item\_Code) — not usable yet; this ran against the old annex2 table where Item\_Code is still stuck as datetime2. Re-run once using the corrected bigint Item\_Code table.



**5. Discount Effectiveness**

Discount	Transactions	Avg Qty/Txn	Total Revenue	Avg Price

Yes	47,362	0.670	₦161,131.32	₦7.01

No	830,680	0.529	₦3,210,892.02	₦9.03



Interpretation: Discounted transactions are a small slice of total volume (\~5.4% of transactions) but move meaningfully more quantity per transaction (+27%) at a lower price (−22%). Per-transaction revenue is nearly a wash (₦4.70 vs ₦4.78) — discounting isn't clearly growing revenue, it's more likely a tool for moving stock (e.g., near-spoilage produce) than a growth lever.



**6. Discount vs Return Correlation**

Discount	Sale/Return	Count

No	return	457

No	sale	830,680

Yes	return	4

Yes	sale	47,362



Interpretation: Returns overwhelmingly come from non-discounted sales (457 of 461, \~99%). Discounted items are almost never returned — which actually supports the idea that discounts are used on items nearing spoilage that customers use quickly, rather than items that turn out to be defective or unwanted.



**7. Price Range**



Min ₦0.10/kg, Max ₦119.90/kg, Avg ₦8.92/kg — wide spread expected across many item types. The ₦0.10 minimum is worth a quick sanity check for data entry error.



**8. Highest Quantity-Sold Days**



Top day: Nov 19, 2022 (2,484.6 kg). Spikes cluster around late 2021–2022 — worth cross-referencing with known market events or holidays.





**Overall Takeaways**

Weekends drive the bulk of revenue — plan inventory/staffing around Sat/Sun.

Revenue is seasonal, with a real slump around Sept–Oct 2021.

Returns spike in that same window — the two patterns together are worth digging into as a possible single root cause.

Discounting doesn't clearly grow revenue, but it does correlate with almost zero returns — likely working as an inventory-clearing tool, not a sales driver.

Two queries (top returned items, top revenue items) still need to be re-run against the corrected Item\_Code table before they're trustworthy.







