WITH a AS (
SELECT fabd.ad_date, 
fc.campaign_name,
fa.adset_name,
fabd.spend,
fabd.impressions,
fabd.reach,
fabd.clicks,
fabd.leads,
fabd.value
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
value
from google_ads_basic_daily gabd
)

SELECT ad_date,
campaign_name,
sum(spend) AS calkowity_koszt,
sum(impressions) AS liczba_wyswietlen,
sum(clicks) AS liczba_clickniec,
sum(value) AS calkowita_wartosc_konwersji
FROM a
GROUP BY 1,2