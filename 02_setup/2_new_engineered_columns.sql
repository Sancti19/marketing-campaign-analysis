-- Added newly engineered columns to improve analysis

ALTER TABLE campaigns
	ADD COLUMN Duration_Bucket VARCHAR(20),
    ADD COLUMN ROI_Category VARCHAR(20),
	ADD COLUMN Cost_Per_Click Decimal(10,4),
    ADD COLUMN Click_Through_Rate Decimal(10,4),
    ADD COLUMN Total_Revenue_Generated Decimal(10,4),
    ADD COLUMN Campaign_Month VARCHAR(20),
    ADD COLUMN Campaign_Year INT;

UPDATE campaigns SET Duration_Bucket =
	CASE
		WHEN Duration = 15 THEN "Short"
        WHEN Duration = 30 THEN "Medium"
        WHEN Duration = 45 THEN "Long"
        ELSE               "Extended"
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



