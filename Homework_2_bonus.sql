SELECT campaign_id,
SUM(spend) as calkowity_koszt,
((sum(value::float)-sum(spend::float))/sum(spend::float))*100 as ROMI
FROM public.facebook_ads_basic_daily
where clicks > 0 
group by campaign_id
having sum(spend) > 500000
order by Romi desc
limit 1