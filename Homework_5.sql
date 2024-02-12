WITH CTE_1 
AS
( 
SELECT 
fabd.ad_date, 
fc.campaign_name,
fa.adset_name,
fabd.spend,
fabd.impressions,
fabd.reach,
fabd.clicks,
fabd.leads,
fabd.value,
fabd.url_parameters 
FROM facebook_ads_basic_daily fabd 
LEFT JOIN facebook_campaign fc USING (campaign_id)
LEFT JOIN facebook_adset fa USING (adset_id)

UNION ALL

SELECT ad_date,
campaign_name,
adset_name,
spend,
impressions,
reach,
clicks,
leads,
value,
url_parameters 
from google_ads_basic_daily gabd
),

CTE_2 
AS 
(
SELECT 
ad_date,
campaign_name,
adset_name,
CASE 
	WHEN spend = 0 THEN NULL
	ELSE spend
END AS spend,
CASE 
	WHEN impressions = 0 THEN NULL
	ELSE impressions
END AS impressions,
reach,
CASE 
	WHEN clicks = 0 THEN NULL
	ELSE clicks
END AS clicks,
leads,
value,
substring(url_parameters,'utm_source=([^&#$]+)') AS UTM_Source_parameters,
substring(url_parameters,'utm_medium=([^&#$]+)') AS UTM_Medium_parameters,
substring(url_parameters,'utm_campaign=([^&#$]+)') AS UTM_Campaign_parameters,
COALESCE (spend, 0),
COALESCE (impressions, 0),
COALESCE (reach, 0),
COALESCE (clicks, 0),
COALESCE (leads, 0),
COALESCE (value, 0)
FROM CTE_1 
)

SELECT 
ad_date, 
CASE 
	WHEN utm_campaign_parameters = 'nan' THEN NULL
	WHEN utm_campaign_parameters = LOWER(utm_campaign_parameters) THEN utm_campaign_parameters
	ELSE NULL
END AS utm_z_warunkami,
 sum(spend) AS total_spend,
 sum(impressions) AS total_impressions,
 sum(clicks) AS total_clicks,
 sum(value) AS total_value,
 sum(spend)/sum(clicks) as CPC,
(sum(spend)/sum(clicks))*1000 as CPM,
(sum(clicks::float)/sum(impressions::float))*100 as CTR,
((sum(value::float)-sum(spend::float))/sum(spend::float))*100 as ROMI

FROM CTE_2 
GROUP BY ad_date, utm_z_warunkami

