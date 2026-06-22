# Marketing Campaign Performance Analysis
### Tools: MySQL · Excel · Power BI | Dataset: Kaggle (200,000 rows) | Duration: End-to-End

---

## Project Overview

This project presents a full end-to-end data analysis of 200,000 marketing campaign records spanning two years across five campaign types, six channels, five audience segments, and five geographic locations. The analysis was conducted entirely using **MySQL** querying.

The central objective was to identify which campaign variables — type, audience, duration, and spend — most significantly drive ROI and conversion performance, and to produce a data-backed budget recommendation for the marketing team.

What makes this project analytically meaningful is not that it produced a clean "winner" — it didn't. It produced something more valuable: a rigorous, multi-dimensional investigation that systematically tested every available variable and reached an honest, evidence-based conclusion about what the data can and cannot support.

---

## Business Problem

The marketing team was allocating budget across five channels — Email, Social Media, Influencer, Display, and Search — without clear visibility into which campaigns were generating returns. Decisions were driven by vanity metrics (impressions, likes) rather than ROI and conversion outcomes. The risk: under-funding high-performing channels while over-investing in low-return ones.

---

## The 4 Business Questions

| # | Question | Purpose |
|---|---|---|
| Q1 | Which campaign type delivers the highest ROI? | Know where to put the budget |
| Q2 | Which audience segments convert best? | Know who to target |
| Q3 | Does campaign duration affect performance? | Know how long to run campaigns |
| Q4 | Is there a spend sweet spot — or do bigger budgets always win? | Avoid over-investing blindly |
| Q5 | Are performance differences statistically significant? | Ensure recommendations aren't based on chance |
| Q6 | How has ROI trended over the 2-year period? | Identify seasonality for future planning |

---

## Dataset

- **Source:** [Kaggle — Marketing Campaign Performance Dataset](https://www.kaggle.com/datasets/manishabhatt22/marketing-campaign-performance-dataset)
- **Size:** 200,000 rows × 17 columns
- **Period:** January 2021 – December 2022
- **Columns:** Campaign_ID, Company, Campaign_Type, Target_Audience, Duration, Channel_Used, Conversion_Rate, Acquisition_Cost, ROI, Location, Language, Clicks, Impressions, Engagement_Score, Customer_Segment, Date

---

## Technical Approach

### Phase 1 — Database Setup & Import (MySQL)
- Created `marketing_analysis` database with correct schema — DATE, DECIMAL, and VARCHAR types assigned from the start
- Imported 200,000 rows via `LOAD DATA LOCAL INFILE` after resolving currency formatting issues (`$` and `,` in Acquisition_Cost) and MySQL local_infile permissions
- Confirmed successful load with row count verification

### Phase 2 — Data Inspection & Quality Check (MySQL)
- Null check across all 16 columns — zero nulls confirmed
- Duplicate Campaign_ID check — no duplicates found
- Distinct value validation across all categorical columns
- Date range confirmed: January 2021 – December 2022
- Numeric outlier check: ROI (2.00–8.00), Acquisition_Cost ($5,000–$20,000), Conversion_Rate (1%–15%) — all within plausible bounds

### Phase 3 — Feature Engineering (MySQL)
Seven new analytical columns were engineered beyond the original 16:

| Column | Formula | Purpose |
|---|---|---|
| `Duration_Bucket` | CASE on Duration days | Group campaigns by length (Short/Medium/Long/Extended) |
| `ROI_Category` | CASE on ROI value | Classify performance tiers |
| `Cost_Per_Click` | Acquisition_Cost / Clicks | Channel cost efficiency metric |
| `Click_Through_Rate` | Clicks / Impressions | Ad visibility effectiveness |
| `Total_Revenue_Generated` | Acquisition_Cost × (ROI + 1) | Derive actual revenue from ROI formula |
| `Campaign_Month` | MONTHNAME(Date) | Time-series analysis |
| `Campaign_Year` | YEAR(Date) | Year-over-year comparison |

### Phase 4 — Star Schema Design (MySQL)
Transformed the flat 23-column table into a proper star schema for optimised Power BI performance:

- **Fact_Campaigns** — 200,000 rows, holds all measurements and foreign keys
- **Dim_Campaign_Setup** — Campaign_Type, Channel_Used, Duration, Duration_Bucket
- **Dim_Audience** — Target_Audience, Customer_Segment
- **Dim_Geography** — Location, Language

### Phase 5 — Business Analysis (MySQL)
Six analytical queries answered each business question directly.


---

## Key Findings

### Q1 — Channel ROI Ranking
Every metric across all 5 campaign types sits in a remarkably tight band:

| Metric | Range |
|---|---|
| Avg ROI | 4.99 – 5.01 |
| Avg Conversion Rate | 7.98% – 8.03% |
| Avg CTR | 13.95% – 14.13% |
| Avg Cost Per Click | $31.92 – $32.10 |

**Finding:** No campaign type meaningfully outperforms any other. The entire dataset is essentially flat across campaign types on every dimension measured.

### Q2 — Audience Segment Performance
- Men 25-34 leads marginally on ROI (5.02); Men 18-24 leads on conversion rate (8.02%) and campaign volume
- Customer segment ROI is completely flat at 5.00 across all five segments
- Foodies edge out slightly on conversion (8.03%) and engagement (5.51)

**Finding:** Audience targeting alone is not a meaningful driver of ROI or conversion in this dataset.

### Q3 — Duration vs Performance
- 30-day (Medium) campaigns post a slight, consistent edge across all four metrics simultaneously
- Spread across all four duration buckets: ROI 5.00–5.01, Conversion 8.00%–8.02%

**Finding:** Campaign duration does not materially affect performance. No duration bucket produces a meaningfully different outcome.

### Q4 — Budget Efficiency
- Avg ROI is completely flat at ~5.00 across all four cost brackets ($5K–$20K)
- Revenue scales linearly with spend: Low bracket ~$39K, Premium bracket ~$108K
- Efficiency (ROI and conversion %) is identical regardless of spend level

**Finding:** There is no spend sweet spot — bigger budgets produce proportionally more revenue but no better efficiency. ROI does not improve with higher acquisition cost.

### Q5 — Statistical Significance (A/B Analysis)
Standard deviation of ROI sits at 1.73–1.74 across every group tested — consistent with a uniform random distribution between 2.00 and 8.00. With ~40,000 samples per group, even a difference of 0.04 in mean ROI would produce a z-score near 3.3, technically crossing the p < 0.05 threshold. However, Cohen's d ≈ 0.02 — well below the 0.20 threshold for even a "small" practical effect.

**Finding:** Any statistically significant result in this dataset reflects the large sample size, not a practically meaningful difference. Effect sizes are negligible across all comparisons.

### Q6 — Time Trends
Month-over-month ROI remained flat across the full 12-month period with no detectable seasonal patterns or growth trajectory.

**Finding:** Time is not a driver of performance variation in this dataset.

---

## The Central Analytical Finding

Across six independent dimensions — campaign type, target audience, customer segment, duration, location, and channel — and six distinct performance metrics, **no categorical variable produced a meaningful difference in ROI, conversion rate, engagement, or revenue efficiency.** Standard deviation analysis confirmed that ROI in this dataset behaves consistently with synthetic random generation: outcomes were likely assigned independently of campaign attributes rather than derived from them.

This is a legitimate and important analytical conclusion. Forcing a "winner" from data that does not support one would have been analytically dishonest and professionally irresponsible.

---

## Recommendations

### Recommendation 1 — Do not reallocate budget based on channel type alone
The data provides no evidence that Email, Social Media, Influencer, Display, or Search performs materially differently. A budget shift between channels, based on this dataset, would be a decision made without data support. The business should instead investigate qualitative factors — creative quality, targeting parameters, message relevance — which this dataset does not capture.

### Recommendation 2 — Investigate what this dataset cannot measure
The uniform performance across all variables strongly suggests that the true drivers of campaign success are factors not present in this dataset: ad creative quality, landing page experience, competitive context, seasonal external factors, and audience intent signals. The business should prioritise instrumenting these variables in future data collection.

### Recommendation 3 — Treat 30-day campaigns as a working default
While the performance difference is not practically significant, Medium-duration (30-day) campaigns posted a consistent marginal edge across every metric simultaneously — the only variable to "win" on all four measures at once. In the absence of stronger evidence, 30 days represents a reasonable default campaign length until richer data becomes available.

### Recommendation 4 — Invest in data quality before the next analysis cycle
A dataset that produces uniform outcomes across 200,000 rows is a data collection problem, not an analytical one. The business should audit its campaign tracking setup to ensure ROI and conversion data is being captured accurately and attributed correctly to individual campaigns, channels, and audience segments before the next analysis cycle.

### Recommendation 5 — Build the dashboard for monitoring, not retrospective analysis
Since historical data does not differentiate performance by category, the Power BI dashboard's primary value shifts from "which channel won last quarter" to "are any channels showing unusual deviation from the 5.00 ROI baseline going forward." Threshold-based alerting in Power BI would be more actionable than comparative bar charts given the current data structure.

---

## Conclusion

This project set out to answer a straightforward business question — which campaign variables drive ROI — and produced an answer that required analytical courage to deliver honestly: none of the available variables, across six dimensions and 200,000 records, meaningfully explain performance variation.

That conclusion required more rigour to reach than a clean "Influencer wins" narrative would have. It demanded systematic testing across every dimension, standard deviation analysis to confirm the pattern was structural rather than coincidental, and the statistical literacy to distinguish between significance driven by large sample sizes and significance driven by real effects.

From a technical standpoint, this project delivered a complete analytics workflow: MySQL database architecture, CSV import troubleshooting, feature engineering across seven new columns, star schema design, multi-dimensional SQL analysis, and exporting database to Power BI dashboard for dashboard creation. Every step was documented, every decision was reasoned, and every finding was presented with appropriate humility.


---

## SQL Queries
All queries are available in [`queries/analysis.sql`](queries/analysis.sql)

## Author
**Blaise Hilary**
[LinkedIn](https://www.linkedin.com/in/blaise-hilary/) · 
