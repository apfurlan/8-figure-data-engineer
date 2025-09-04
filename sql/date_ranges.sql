
WITH daily_metrics AS (
    SELECT 		
        date,
        date(date - INTERVAL '30 days') as window_prev_date, 
        AVG(spend/conversions) as avg_CAC,
        AVG(conversions*100/spend) as avg_ROAS,
        SUM(spend/conversions) as sum_CAC,
        SUM(conversions*100/spend) as sum_ROAS
    FROM postgres.public.ads_spend
    GROUP BY date
)
SELECT 
    date,
    window_prev_date,
    avg_cac,
    LAG(avg_cac, 30) OVER (ORDER BY date) as avg_cac_window_prev_date,
    avg_roas,
    LAG(avg_roas, 30) OVER (ORDER BY date) as avg_roas_window_prev_date,
    avg_cac - LAG(avg_cac, 30) OVER (ORDER BY date) as avg_cac_delta,
    avg_roas - LAG(avg_roas, 30) OVER (ORDER BY date) as avg_roas_delta,
    -- 
    sum_cac,
    LAG(sum_cac, 30) OVER (ORDER BY date) as sum_cac_window_prev_date,
    sum_roas,
    LAG(sum_roas, 30) OVER (ORDER BY date) as sum_roas_window_prev_date,
    sum_cac - LAG(sum_cac, 30) OVER (ORDER BY date) as sum_cac_delta,
    sum_roas - LAG(sum_roas, 30) OVER (ORDER BY date) as sum_roas_delta
FROM daily_metrics
where date >= date('2025-03-02')
ORDER BY date desc;