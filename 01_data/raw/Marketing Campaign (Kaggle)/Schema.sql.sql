-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: marketing_analysis
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `campaigns`
--

DROP TABLE IF EXISTS `campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaigns` (
  `Campaign_ID` varchar(20) DEFAULT NULL,
  `Company` varchar(100) DEFAULT NULL,
  `Campaign_Type` varchar(50) DEFAULT NULL,
  `Target_Audience` varchar(50) DEFAULT NULL,
  `Duration` int DEFAULT NULL,
  `Channel_Used` varchar(50) DEFAULT NULL,
  `Conversion_Rate` decimal(5,4) DEFAULT NULL,
  `Acquisition_Cost` decimal(10,2) DEFAULT NULL,
  `ROI` decimal(8,2) DEFAULT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `Language` varchar(50) DEFAULT NULL,
  `Clicks` int DEFAULT NULL,
  `Impressions` int DEFAULT NULL,
  `Engagement_Score` decimal(5,2) DEFAULT NULL,
  `Customer_Segment` varchar(50) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Duration_Bucket` varchar(20) DEFAULT NULL,
  `ROI_Category` varchar(20) DEFAULT NULL,
  `Cost_Per_Click` decimal(10,4) DEFAULT NULL,
  `Click_Through_Rate` decimal(10,4) DEFAULT NULL,
  `Total_Revenue_Generated` decimal(10,4) DEFAULT NULL,
  `Campaign_Month` varchar(20) DEFAULT NULL,
  `Campaign_Year` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_audience`
--

DROP TABLE IF EXISTS `dim_audience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_audience` (
  `Audience_ID` bigint unsigned NOT NULL DEFAULT '0',
  `Target_Audience` varchar(50) DEFAULT NULL,
  `Customer_Segment` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_campaign_setup`
--

DROP TABLE IF EXISTS `dim_campaign_setup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_campaign_setup` (
  `Setup_ID` bigint unsigned NOT NULL DEFAULT '0',
  `Campaign_Type` varchar(50) DEFAULT NULL,
  `Channel_Used` varchar(50) DEFAULT NULL,
  `Duration` int DEFAULT NULL,
  `Duration_Bucket` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_geography`
--

DROP TABLE IF EXISTS `dim_geography`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_geography` (
  `Geography_ID` bigint unsigned NOT NULL DEFAULT '0',
  `Location` varchar(100) DEFAULT NULL,
  `Language` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fact_campaigns`
--

DROP TABLE IF EXISTS `fact_campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_campaigns` (
  `Campaign_ID` varchar(20) DEFAULT NULL,
  `Company` varchar(100) DEFAULT NULL,
  `Setup_ID` bigint unsigned NOT NULL DEFAULT '0',
  `Audience_ID` bigint unsigned NOT NULL DEFAULT '0',
  `Geography_ID` bigint unsigned NOT NULL DEFAULT '0',
  `Conversion_Rate` decimal(5,4) DEFAULT NULL,
  `Acquisition_Cost` decimal(10,2) DEFAULT NULL,
  `ROI` decimal(8,2) DEFAULT NULL,
  `Clicks` int DEFAULT NULL,
  `Impressions` int DEFAULT NULL,
  `Engagement_Score` decimal(5,2) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `ROI_Category` varchar(20) DEFAULT NULL,
  `Cost_Per_Click` decimal(10,4) DEFAULT NULL,
  `Click_Through_Rate` decimal(10,4) DEFAULT NULL,
  `Total_Revenue_Generated` decimal(10,4) DEFAULT NULL,
  `Campaign_Month` varchar(20) DEFAULT NULL,
  `Campaign_Year` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-25 11:47:18
