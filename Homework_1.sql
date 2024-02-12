SELECT ad_date, spend, clicks, spend / clicks AS spend_click_Ratio /* extracting data and making spend/click metric */
FROM public.facebook_ads_basic_daily
WHERE  clicks > 0    /* boundaries */
ORDER BY ad_date DESC
/* simple code to get familiarized with SQL,  */
