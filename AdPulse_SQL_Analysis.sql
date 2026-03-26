/*
=============================================================================
PROJECT: AdPulse — Digital Marketing Campaign Performance Analysis
ANALYST: Mustapha Ambali
DATE: March 2026
TOOL: SQL Server
=============================================================================
BUSINESS PROBLEM:
AdPulse Media's Head of Strategy raised concerns that marketing spend is not
being allocated efficiently. Campaigns are running across multiple channels,
segments, and locations without a centralized analytics view — leading to
budget decisions based on gut feel rather than data.

OBJECTIVE:
Conduct a full performance audit of 200,000 campaigns across 11 months to
identify inefficiencies and deliver actionable budget reallocation recommendations.

DATASET: marketing_campaign
RECORDS: 200,000
DATE RANGE: 11 Months
DIMENSIONS: 5 Companies | 6 Channels | 5 Campaign Types | 5 Segments | 5 Locations
DATA QUALITY: No nulls | No duplicates | All values within normal range
=============================================================================
*/


-- =============================================================================
-- PHASE 1: DATA FAMILIARIZATION & QUALITY CHECKS
-- =============================================================================

-- 1.1 Preview the dataset
SELECT TOP 10 * 
FROM marketing_campaign;

-- 1.2 Total records
SELECT COUNT(*) AS total_records 
FROM marketing_campaign;

-- 1.3 Date range coverage
SELECT 
    MIN(Date) AS campaign_start,
    MAX(Date) AS campaign_end,
    DATEDIFF(MONTH, MIN(Date), MAX(Date)) AS months_covered
FROM marketing_campaign;

-- 1.4 Unique companies and campaigns
SELECT 
    COUNT(DISTINCT Company) AS total_companies,
    COUNT(DISTINCT Campaign_ID) AS total_campaigns
FROM marketing_campaign;

-- 1.5 Channel distribution
SELECT 
    Channel_Used, 
    COUNT(*) AS campaign_count
FROM marketing_campaign
GROUP BY Channel_Used
ORDER BY campaign_count DESC;

-- 1.6 Campaign type distribution
SELECT 
    Campaign_Type, 
    COUNT(*) AS campaign_count
FROM marketing_campaign
GROUP BY Campaign_Type
ORDER BY campaign_count DESC;

-- 1.7 Customer segment distribution
SELECT 
    Customer_Segment, 
    COUNT(*) AS campaign_count
FROM marketing_campaign
GROUP BY Customer_Segment
ORDER BY campaign_count DESC;

-- 1.8 Location distribution
SELECT 
    Location, 
    COUNT(*) AS campaign_count
FROM marketing_campaign
GROUP BY Location
ORDER BY campaign_count DESC;

-- 1.9 NULL value check across all key columns
SELECT
    SUM(CASE WHEN Campaign_ID IS NULL THEN 1 ELSE 0 END) AS null_campaign_id,
    SUM(CASE WHEN Channel_Used IS NULL THEN 1 ELSE 0 END) AS null_channel,
    SUM(CASE WHEN Campaign_Type IS NULL THEN 1 ELSE 0 END) AS null_campaign_type,
    SUM(CASE WHEN Conversion_Rate IS NULL THEN 1 ELSE 0 END) AS null_conversion_rate,
    SUM(CASE WHEN Acquisition_Cost IS NULL THEN 1 ELSE 0 END) AS null_acq_cost,
    SUM(CASE WHEN ROI IS NULL THEN 1 ELSE 0 END) AS null_roi,
    SUM(CASE WHEN Clicks IS NULL THEN 1 ELSE 0 END) AS null_clicks,
    SUM(CASE WHEN Impressions IS NULL THEN 1 ELSE 0 END) AS null_impressions,
    SUM(CASE WHEN Engagement_Score IS NULL THEN 1 ELSE 0 END) AS null_engagement,
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS null_date
FROM marketing_campaign;

-- 1.10 Duplicate Campaign ID check
SELECT 
    Campaign_ID, 
    COUNT(*) AS occurrences
FROM marketing_campaign
GROUP BY Campaign_ID
HAVING COUNT(*) > 1;

-- 1.11 Value range validation
SELECT 
    MIN(Conversion_Rate) AS min_conv_rate,
    MAX(Conversion_Rate) AS max_conv_rate,
    MIN(ROI) AS min_roi,
    MAX(ROI) AS max_roi,
    MIN(Acquisition_Cost) AS min_acq_cost,
    MAX(Acquisition_Cost) AS max_acq_cost,
    MIN(Clicks) AS min_clicks,
    MAX(Clicks) AS max_clicks,
    MIN(Impressions) AS min_impressions,
    MAX(Impressions) AS max_impressions
FROM marketing_campaign;

/*
DATA QUALITY RESULT:
- No NULL values found across all key columns
- No duplicate Campaign IDs detected
- All metric values within expected normal ranges
- Dataset confirmed clean and analysis-ready
*/


-- =============================================================================
-- PHASE 2: EXPLORATORY DATA ANALYSIS
-- =============================================================================

-- -----------------------------------------------------------------------------
-- FINDING 1: CHANNEL PERFORMANCE
-- Business Question: Which channel delivers the best ROI and efficiency?
-- -----------------------------------------------------------------------------

SELECT
    Channel_Used,
    SUM(Acquisition_Cost) AS Total_Acq_Cost,
    AVG(ROI) AS Avg_ROI,
    ROUND(SUM(Clicks) * 100.0 / NULLIF(SUM(Impressions), 0), 2) AS CTR
FROM marketing_campaign
GROUP BY Channel_Used
ORDER BY AVG(ROI) DESC;

/*
KEY FINDINGS:
- Facebook delivers the strongest ROI at moderate cost — most efficient channel
- Website achieves the best CTR with lower acquisition cost than Email
- Email has the highest acquisition cost but near-equal ROI to Facebook (0.1 difference)
RECOMMENDATION: Partially reallocate Email budget to Facebook and Website
*/


-- -----------------------------------------------------------------------------
-- FINDING 2: CAMPAIGN TYPE & CUSTOMER SEGMENT PERFORMANCE
-- Business Question: Which campaign type works best for each customer segment?
-- -----------------------------------------------------------------------------

SELECT
    Campaign_Type,
    Customer_Segment,
    SUM(Acquisition_Cost) AS Total_Acq_Cost,
    AVG(ROI) AS Avg_ROI,
    ROUND(SUM(Clicks) * 100.0 / NULLIF(SUM(Impressions), 0), 2) AS CTR
FROM marketing_campaign
GROUP BY Campaign_Type, Customer_Segment
ORDER BY AVG(ROI) DESC;

/*
KEY FINDINGS:
- Influencer + Tech Enthusiasts is the star combination (ROI: 5.03)
- Email + Outdoor Adventurers is the weakest combination (ROI: 4.96)
- Outdoor Adventurers perform strongly with Display campaigns (ROI: 5.02)
  indicating a channel-segment mismatch, not a weak segment
RECOMMENDATION: Shift Outdoor Adventurers budget from Email to Display campaigns
*/


-- -----------------------------------------------------------------------------
-- FINDING 3: GEOGRAPHIC PERFORMANCE
-- Business Question: Which locations deliver the best ROI relative to spend?
-- -----------------------------------------------------------------------------

SELECT
    Location,
    SUM(Acquisition_Cost) AS Total_Acq_Cost,
    AVG(ROI) AS Avg_ROI,
    ROUND(SUM(Clicks) * 100.0 / NULLIF(SUM(Impressions), 0), 2) AS CTR
FROM marketing_campaign
GROUP BY Location
ORDER BY AVG(ROI) DESC;

/*
KEY FINDINGS:
- Miami: highest ROI, highest cost — spend justified
- Houston: strong ROI at lowest acquisition cost — most efficient location
- New York: high cost, lowest ROI — weakest value proposition
- Chicago: decent ROI relative to cost — balanced performance
RECOMMENDATION: Reallocate New York budget to Houston. Maintain Miami and Chicago.
*/


-- -----------------------------------------------------------------------------
-- FINDING 4: MONTHLY PERFORMANCE TRENDS
-- Business Question: When should we spend more or less throughout the year?
-- -----------------------------------------------------------------------------

SELECT
    MONTH(Date) AS Month_Number,
    FORMAT(Date, 'MMM') AS Month_Name,
    SUM(Acquisition_Cost) AS Total_Acq_Cost,
    AVG(ROI) AS Avg_ROI,
    ROUND(SUM(Clicks) * 100.0 / NULLIF(SUM(Impressions), 0), 2) AS CTR
FROM marketing_campaign
GROUP BY MONTH(Date), FORMAT(Date, 'MMM')
ORDER BY MONTH(Date);

/*
KEY FINDINGS:
- May and October are peak ROI months — best time to increase spend
- February is the most cost-efficient month — lowest spend, competitive ROI
- August has the highest spend but poor ROI — biggest budget wastage month
- July is the weakest performing month overall
- CTR is stable at ~10% year-round — performance gaps are spend-driven not audience-driven
RECOMMENDATION: Reduce August budget, increase investment in May and October
*/


-- -----------------------------------------------------------------------------
-- FINDING 5A: TARGET AUDIENCE PERFORMANCE — OVERALL
-- Business Question: Which audience segments deliver the best returns?
-- -----------------------------------------------------------------------------

SELECT
    Target_Audience,
    SUM(Acquisition_Cost) AS Total_Acq_Cost,
    AVG(ROI) AS Avg_ROI,
    ROUND(SUM(Clicks) * 100.0 / NULLIF(SUM(Impressions), 0), 2) AS CTR
FROM marketing_campaign
GROUP BY Target_Audience
ORDER BY AVG(ROI) DESC;


-- -----------------------------------------------------------------------------
-- FINDING 5B: TARGET AUDIENCE + CHANNEL PERFORMANCE
-- Business Question: Which channel works best for each audience group?
-- -----------------------------------------------------------------------------

SELECT
    Target_Audience,
    Channel_Used,
    SUM(Acquisition_Cost) AS Total_Acq_Cost,
    AVG(ROI) AS Avg_ROI,
    ROUND(SUM(Clicks) * 100.0 / NULLIF(SUM(Impressions), 0), 2) AS CTR
FROM marketing_campaign
GROUP BY Target_Audience, Channel_Used
ORDER BY AVG(ROI) DESC;

/*
KEY FINDINGS:
- Men 25-34 are the star audience — highest ROI, lowest spend, best on Facebook
- Women 35-44 are an underinvested hidden gem — strong ROI at minimal cost
- Men 18-24 are the biggest budget problem — highest spend, lowest ROI on Instagram & Email
- Email underperforms across multiple audiences reinforcing Finding #1
RECOMMENDATION: Increase investment in Men 25-34 via Facebook and Women 35-44.
Significantly reduce Men 18-24 spend on Instagram and Email.
*/


-- =============================================================================
-- PHASE 3: SUMMARY OF RECOMMENDATIONS
-- =============================================================================

/*
FINDING 1 — Channel Performance
Reallocate Email budget to Facebook and Website

FINDING 2 — Campaign Type & Segment
Shift Outdoor Adventurers campaigns from Email to Display

FINDING 3 — Geographic Performance
Reallocate New York budget to Houston. Maintain Miami and Chicago.

FINDING 4 — Monthly Trends
Reduce August spend. Increase investment in May and October campaigns.

FINDING 5 — Target Audience
Increase investment in Men 25-34 via Facebook and Women 35-44.
Reduce Men 18-24 spend on Instagram and Email.
*/
