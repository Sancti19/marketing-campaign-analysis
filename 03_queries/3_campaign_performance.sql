-- Which campaign type delivers the highest ROI & Revenue?
SELECT
	Campaign_Type,
    COUNT(*)		AS Total_Campaigns,
    ROUND(AVG(ROI),2)	AS Avg_ROI,
    ROUND(AVG(Conversion_Rate)*100, 2) AS Avg_Conversation_Pct,
    ROUND(AVG(Click_Through_Rate)*100, 2)  AS Avg_CTC_Pct,
    ROUND(AVG(Cost_Per_Click), 2)         AS Avg_CPC,
	ROUND(SUM(Total_Revenue_Generated), 2) AS Total_Revenue
FROM campaigns
GROUP BY Campaign_Type
ORDER BY Avg_ROI DESC;

-- Does audience segment converts more?
-- Query by Target_Audience
SELECT
	Target_Audience,
    COUNT(*)       AS Total_Campaign,
    ROUND(Avg(ROI),2) AS Avg_ROI,
    ROUND(Avg(Conversion_Rate)*100,2) AS Avg_Conversion_Pct,
    ROUND(Sum(Total_Revenue_Generated), 2) AS Total_Revenue
FROM campaigns
GROUP BY Target_Audience
ORDER BY Avg_ROI DESC;

-- Query by Customer Segment
SELECT
	Customer_Segment,
    COUNT(*)  AS Total_Campaign,
    ROUND(Avg(ROI),2) AS Avg_ROI,
    ROUND(Avg(Conversion_Rate)*100,2) AS Avg_Conversion_Pct,
    ROUND(AVG(Engagement_Score), 2)       AS Avg_Engagement,
    ROUND(Sum(Total_Revenue_Generated), 2) AS Total_Revenue
FROM campaigns
GROUP BY Customer_Segment
ORDER BY Avg_Engagement DESC;

-- Does campaign duration affect performance?
SELECT
  Duration,
  Duration_Bucket,
  COUNT(*)                             AS Total_Campaigns,
  ROUND(AVG(ROI), 2)                   AS Avg_ROI,
  ROUND(AVG(Conversion_Rate) * 100, 2) AS Avg_Conversion_Pct,
  ROUND(AVG(Engagement_Score), 2)      AS Avg_Engagement,
  ROUND(AVG(Total_Revenue_Generated), 2) AS Avg_Revenue
FROM campaigns
GROUP BY Duration, Duration_Bucket
ORDER BY Duration;

-- Look at Min, Max, and Standard Deviation
SELECT 
    Duration,
    Duration_Bucket,
    COUNT(*) AS Total_Campaigns,
    ROUND(AVG(ROI), 2) AS Avg_ROI,
    -- Check the risk/volatility
    ROUND(MIN(ROI), 2) AS Min_ROI,
    ROUND(MAX(ROI), 2) AS Max_ROI,
    ROUND(STDDEV(ROI), 2) AS ROI_Standard_Deviation
FROM campaigns
GROUP BY Duration, Duration_Bucket
ORDER BY Duration;

-- Cross-Reference with Campaign Type
SELECT 
    Duration_Bucket,
    Campaign_Type,
    ROUND(AVG(ROI), 2) AS Avg_ROI,
    ROUND(AVG(Conversion_Rate) * 100, 2) AS Avg_Conversion_Pct
FROM campaigns
GROUP BY Duration_Bucket, Campaign_Type
ORDER BY Campaign_Type, Duration_Bucket;


-- Do bigger budget always win?
SELECT
  CASE
    WHEN Acquisition_Cost < 8000  THEN '1 - Low ($5K-$8K)'
    WHEN Acquisition_Cost < 12000 THEN '2 - Mid ($8K-$12K)'
    WHEN Acquisition_Cost < 16000 THEN '3 - High ($12K-$16K)'
    ELSE                               '4 - Premium ($16K-$20K)'
  END AS Cost_Bracket,
  COUNT(*)                              AS Total_Campaigns,
  ROUND(AVG(ROI), 2)                    AS Avg_ROI,
  ROUND(AVG(Conversion_Rate) * 100, 2)  AS Avg_Conversion_Pct,
  ROUND(AVG(Total_Revenue_Generated), 2) AS Avg_Revenue
FROM campaigns
GROUP BY Cost_Bracket
ORDER BY Cost_Bracket;
