SELECT COUNT(*) AS total_rows FROM marketing_campaign_dataset;
USE marketing_analysis;
DROP TABLE IF EXISTS marketing_campaign_dataset;


SET GLOBAL local_infile = 1;

CREATE TABLE campaigns (
    Campaign_ID      VARCHAR(20),
    Company          VARCHAR(100),
    Campaign_Type    VARCHAR(50),
    Target_Audience  VARCHAR(50),
    Duration         INT,
    Channel_Used     VARCHAR(50),
    Conversion_Rate  DECIMAL(5,2),
    Acquisition_Cost DECIMAL(10,2),
    ROI              DECIMAL(8,2),
    Location         VARCHAR(100),
    Language         VARCHAR(50),
    Clicks           INT,
    Impressions      INT,
    Engagement_Score DECIMAL(5,2),
    Customer_Segment VARCHAR(50),
    Date             VARCHAR(20),
    Budget           DECIMAL(12,2)
);

LOAD DATA LOCAL INFILE 'C:/Users/Blais/OneDrive/Documentos/PORTFOLIO PROJECTS/PROJECTS/Marketing Campaign (Kaggle)/marketing_campaign_dataset.csv'
INTO TABLE campaigns
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_rows FROM campaigns;

-- See the first 10 rows
SELECT * FROM campaigns LIMIT 10;

SELECT * FROM campaigns LIMIT 10;

-- Check all column names came through correctly
DESCRIBE campaigns;



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

SELECT * FROM campaigns LIMIT 10;

USE marketing_analysis;
ALTER TABLE campaigns DROP COLUMN Budget;

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

-- Date rangeROI
SELECT MIN(Date) AS earliest, MAX(Date) AS latest FROM campaigns;

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

DROP TABLE IF EXISTS campaigns;

CREATE TABLE campaigns (
    Campaign_ID      VARCHAR(20),
    Company          VARCHAR(100),
    Campaign_Type    VARCHAR(50),
    Target_Audience  VARCHAR(50),
    Duration         INT,
    Channel_Used     VARCHAR(50),
    Conversion_Rate  DECIMAL(5,4),
    Acquisition_Cost DECIMAL(10,2),
    ROI              DECIMAL(8,2),
    Location         VARCHAR(100),
    Language         VARCHAR(50),
    Clicks           INT,
    Impressions      INT,
    Engagement_Score DECIMAL(5,2),
    Customer_Segment VARCHAR(50),
    Date             VARCHAR(20)
);

LOAD DATA LOCAL INFILE 'C:/Users/Blais/OneDrive/Documentos/PORTFOLIO PROJECTS/PROJECTS/Marketing Campaign (Kaggle)/marketing_campaign_dataset.csv'
INTO TABLE campaigns
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM campaigns LIMIT 10;
SELECT COUNT(*) AS total_rows FROM campaigns;
SELECT
  ROUND(MIN(Acquisition_Cost), 2) AS min_cost,
  ROUND(MAX(Acquisition_Cost), 2) AS max_cost,
  ROUND(AVG(Acquisition_Cost), 2) AS avg_cost,
  ROUND(MIN(ROI), 2)              AS min_roi,
  ROUND(MAX(ROI), 2)              AS max_roi,
  ROUND(AVG(ROI), 2)              AS avg_roi,
  ROUND(MIN(Conversion_Rate), 4)  AS min_conversion,
  ROUND(MAX(Conversion_Rate), 4)  AS max_conversion,
  ROUND(AVG(Conversion_Rate), 4)  AS avg_conversion
FROM campaigns;

DESCRIBE campaigns;

-- Safe update mode turn-off if MySQL Workbench blocks your update
SET SQL_SAFE_UPDATES = 0;

UPDATE campaigns 
SET Date = DATE_FORMAT(STR_TO_DATE(Date, '%d/%m/%Y'), '%Y-%m-%d');

-- Re-enable safe updates
SET SQL_SAFE_UPDATES = 1;

ALTER TABLE campaigns MODIFY COLUMN Date DATE;

ALTER TABLE campaigns
	ADD COLUMN Duration_Bucket VARCHAR(20),
    ADD COLUMN ROI_Category VARCHAR(20),
	ADD COLUMN Cost_Per_Click Decimal(10,4),
    ADD COLUMN Click_Through_Rate Decimal(10,4),
    ADD COLUMN Total_Revenue_Generated Decimal(10,4),
    ADD COLUMN Campaign_Month VARCHAR(20),
    ADD COLUMN Campaign_Year INT;

SELECT DISTINCT Duration FROM campaigns;

UPDATE campaigns SET Duration_Bucket =
	CASE
		WHEN Duration = 15 THEN "Short"
        WHEN Duration = 30 THEN "Medium"
        WHEN Duration = 45 THEN "Long"
        ELSE 					"Extended"
END;

UPDATE campaigns SET ROI_Category =
	CASE
		WHEN ROI < 3 THEN "Low"
        WHEN ROI < 5 THEN "Below Average"
        WHEN ROI < 7 THEN "Above Average"
        ELSE				"High"
END;

SELECT ROI_Category, COUNT(*) AS count,
       ROUND(AVG(ROI), 2) AS avg_roi
FROM campaigns
GROUP BY ROI_Category
ORDER BY avg_roi;

UPDATE campaigns
SET Cost_Per_Click = Acquisition_Cost/NULLIF(Clicks,0);

SELECT
	Campaign_ID,
    Acquisition_Cost,
    Clicks,
    Cost_Per_Click,
    ROI,
    Total_Revenue_Generated,
    Impressions,
    Click_Through_Rate,
    Campaign_Month,
    Campaign_Year
FROM campaigns
LIMIT 10;

UPDATE campaigns
SET Total_Revenue_Generated = Acquisition_Cost* (ROI + 1);

UPDATE campaigns
SET Click_Through_Rate = Clicks/NULLIF(Impressions,0);

UPDATE campaigns
SET Campaign_Month = Month(Date),
	Campaign_Year = Year(Date);
    
SELECT * FROM campaigns LIMIT 10;

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


SELECT 
    Campaign_Type, 
    Duration_Bucket, 
    Customer_Segment,
    COUNT(*) AS High_Performer_Count
FROM campaigns
WHERE ROI >= 7.0
GROUP BY Campaign_Type, Duration_Bucket, Customer_Segment
ORDER BY High_Performer_Count DESC
LIMIT 10;

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

-- checking standard deviation within groups, and checking Location
SELECT
  Location,
  COUNT(*)              AS Total_Campaigns,
  ROUND(AVG(ROI), 2)    AS Avg_ROI,
  ROUND(STDDEV(ROI), 2) AS StdDev_ROI
FROM campaigns
GROUP BY Location
ORDER BY Avg_ROI DESC;


SELECT
  Channel_Used,
  COUNT(*)                              AS N,
  ROUND(AVG(ROI), 2)                    AS Mean_ROI,
  ROUND(STDDEV(ROI), 2)                 AS StdDev_ROI,
  ROUND(AVG(Conversion_Rate) * 100, 2)  AS Avg_Conversion_Pct
FROM campaigns
GROUP BY Channel_Used
ORDER BY Mean_ROI DESC;

SELECT Channel_Used, ROI
FROM campaigns
WHERE Channel_Used IN ('Facebook', 'Website');
-- ORDER BY Channel_Used;

SELECT Channel_Used, COUNT(*) AS row_count
FROM campaigns
WHERE Channel_Used IN ('Facebook', 'Website')
GROUP BY Channel_Used;


SELECT
  Campaign_Year,
  Campaign_Month,
  COUNT(*)                              AS Total_Campaigns,
  ROUND(AVG(ROI), 2)                    AS Avg_ROI,
  ROUND(AVG(Conversion_Rate) * 100, 2)  AS Avg_Conversion_Pct,
  ROUND(SUM(Total_Revenue_Generated), 2) AS Total_Revenue
FROM campaigns
GROUP BY Campaign_Year, Campaign_Month
ORDER BY Campaign_Year,
  CASE Campaign_Month
    WHEN 'January'   THEN 1  WHEN 'February' THEN 2
    WHEN 'March'     THEN 3  WHEN 'April'    THEN 4
    WHEN 'May'       THEN 5  WHEN 'June'     THEN 6
    WHEN 'July'      THEN 7  WHEN 'August'   THEN 8
    WHEN 'September' THEN 9  WHEN 'October'  THEN 10
    WHEN 'November'  THEN 11 WHEN 'December' THEN 12
  END;


ALTER TABLE campaigns 
MODIFY COLUMN Campaign_Month VARCHAR(20);

UPDATE campaigns
SET Campaign_Month = MONTHNAME(Date),
    Campaign_Year  = YEAR(Date);

DESCRIBE campaigns;

SELECT 
  Campaign_ID,
  Clicks,
  Impressions,
  Click_Through_Rate,
  Cost_Per_Click,
  Acquisition_Cost
FROM campaigns
LIMIT 10;


CREATE TABLE Dim_Campaign_Setup AS
SELECT
  ROW_NUMBER() OVER (ORDER BY Campaign_Type, Channel_Used, Duration) AS Setup_ID,
  Campaign_Type,
  Channel_Used,
  Duration,
  Duration_Bucket
FROM (
  SELECT DISTINCT Campaign_Type, Channel_Used, Duration, Duration_Bucket
  FROM campaigns
) AS unique_setups;

CREATE TABLE Dim_Audience AS
SELECT
  ROW_NUMBER() OVER (ORDER BY Target_Audience, Customer_Segment) AS Audience_ID,
  Target_Audience,
  Customer_Segment
FROM (
  SELECT DISTINCT Target_Audience, Customer_Segment
  FROM campaigns
) AS unique_audiences;

CREATE TABLE Dim_Geography AS
SELECT
  ROW_NUMBER() OVER (ORDER BY Location, Language) AS Geography_ID,
  Location,
  Language
FROM (
  SELECT DISTINCT Location, Language
  FROM campaigns
) AS unique_geo;

SELECT COUNT(*) FROM Dim_Campaign_Setup;
SELECT COUNT(*) FROM Dim_Audience;
SELECT COUNT(*) FROM Dim_Geography;

CREATE TABLE Fact_Campaigns AS
SELECT
  c.Campaign_ID,
  c.Company,
  s.Setup_ID,
  a.Audience_ID,
  g.Geography_ID,
  c.Conversion_Rate,
  c.Acquisition_Cost,
  c.ROI,
  c.Clicks,
  c.Impressions,
  c.Engagement_Score,
  c.Date,
  c.ROI_Category,
  c.Cost_Per_Click,
  c.Click_Through_Rate,
  c.Total_Revenue_Generated,
  c.Campaign_Month,
  c.Campaign_Year
FROM campaigns c
JOIN Dim_Campaign_Setup s
  ON c.Campaign_Type = s.Campaign_Type
  AND c.Channel_Used = s.Channel_Used
  AND c.Duration = s.Duration
JOIN Dim_Audience a
  ON c.Target_Audience = a.Target_Audience
  AND c.Customer_Segment = a.Customer_Segment
JOIN Dim_Geography g
  ON c.Location = g.Location
  AND c.Language = g.Language;
  
  SELECT COUNT(*) AS fact_rows FROM Fact_Campaigns;
  
  SELECT
  s.Campaign_Type,
  COUNT(*) AS Total_Campaigns,
  ROUND(AVG(f.ROI), 2) AS Avg_ROI
FROM Fact_Campaigns f
JOIN Dim_Campaign_Setup s ON f.Setup_ID = s.Setup_ID
GROUP BY s.Campaign_Type
ORDER BY Avg_ROI DESC;