SELECT ad_date, campaign_id, SUM(spend) as calkowity_koszt, sum(impressions) as liczba_wyswietlen, sum(clicks) as liczba_clickniec, sum(value) as calkowita_wartosc,
sum(spend)/sum(clicks) as CPC,
(sum(spend)/sum(clicks))*1000 as CPM,
(sum(clicks::float)/sum(impressions::float))*100 as CTR,
((sum(value::float)-sum(spend::float))/sum(spend::float))*100 as ROMI
FROM public.facebook_ads_basic_daily
where clicks > 0
group by ad_date, campaign_id
/* another simple query, making some new metrics grouped by date and campaign id */
