-- Quick stats on your key numeric columns
SELECT
	ROUND(min(ROI), 2) AS min_roi,
    ROUND(max(ROI), 2) AS max_roi,
    ROUND(avg(ROI), 2) AS avg_roi,
    ROUND(min(Budget), 2) AS min_budget,
    ROUND(max(Budget), 2) AS max_budget
FROM campaigns;

-- Null checks across key columns
SELECT
  SUM(CASE WHEN ROI              IS NULL THEN 1 ELSE 0 END) AS null_roi,
  SUM(CASE WHEN Campaign_Type    IS NULL THEN 1 ELSE 0 END) AS null_type,
  SUM(CASE WHEN Target_Audience  IS NULL THEN 1 ELSE 0 END) AS null_audience,
  SUM(CASE WHEN Conversion_Rate  IS NULL THEN 1 ELSE 0 END) AS null_conv_rate
FROM campaigns;

-- Duplicates check
SELECT Campaign_ID,
	COUNT(*) AS occurences
FROM campaigns
GROUP BY Campaign_ID
HAVING COUNT(*) > 1; 

-- Distinct Category values
SELECT DISTINCT Campaign_Type  FROM campaigns ORDER BY 1;
SELECT DISTINCT Target_Audience FROM campaigns ORDER BY 1;
SELECT DISTINCT Language        FROM campaigns ORDER BY 1;
SELECT DISTINCT Location        FROM campaigns ORDER BY 1;
SELECT DISTINCT Customer_Segment FROM campaigns ORDER BY 1;

-- Outlier check 
SELECT
  ROUND(MIN(ROI), 2)              AS min_roi,
  ROUND(MAX(ROI), 2)              AS max_roi,
  ROUND(AVG(ROI), 2)              AS avg_roi,
  ROUND(MIN(Acquisition_Cost), 2) AS min_acq_cost,
  ROUND(MAX(Acquisition_Cost), 2) AS max_acq_cost,
  ROUND(AVG(Acquisition_Cost), 2) AS avg_acq_cost,
  ROUND(MIN(Conversion_Rate), 4)  AS min_conversion,
  ROUND(MAX(Conversion_Rate), 4)  AS max_conversion,
  ROUND(AVG(Conversion_Rate), 4)  AS avg_conversion,
  ROUND(MIN(Clicks), 0)           AS min_clicks,
  ROUND(MAX(Clicks), 0)           AS max_clicks,
  ROUND(AVG(Clicks), 0)           AS avg_clicks,
  ROUND(MIN(Impressions), 0)      AS min_impressions,
  ROUND(MAX(Impressions), 0)      AS max_impressions,
  ROUND(MIN(Engagement_Score), 2) AS min_engagement,
  ROUND(MAX(Engagement_Score), 2) AS max_engagement
FROM campaigns;
