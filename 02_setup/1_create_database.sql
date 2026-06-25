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

