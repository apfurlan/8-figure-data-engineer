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
),
moving_sum_average as (
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
ORDER BY date desc)
select 
	date,
	window_prev_date,
	avg_cac,
	avg_cac_window_prev_date,
	avg_cac_delta,
	sum_cac,
	sum_cac_window_prev_date,
	sum_cac_delta,
	case 
		when avg_cac > avg_cac_window_prev_date then round((((avg_cac) - (avg_cac_window_prev_date)) / avg_cac_window_prev_date) * 100,2)
		else round(((-(avg_cac) + (avg_cac_window_prev_date)) / avg_cac_window_prev_date) * 100,2)
	end as perc_delta_avg_cac, 
	case 
		when sum_cac > sum_cac_window_prev_date then round((((sum_cac) - (sum_cac_window_prev_date)) / sum_cac_window_prev_date) * 100,2)
		else round(((-(sum_cac) + (sum_cac_window_prev_date)) / sum_cac_window_prev_date) * 100,2)
	end as perc_delta_sum_cac,
	avg_roas,
	avg_roas_window_prev_date,
	avg_roas_delta,
	sum_roas,
	sum_roas_window_prev_date,
	sum_roas_delta,
	case 
		when avg_roas > avg_roas_window_prev_date then round((((avg_roas) - (avg_roas_window_prev_date)) / avg_roas_window_prev_date) * 100,2)
		else round(((-(avg_roas) + (avg_roas_window_prev_date)) / avg_roas_window_prev_date) * 100,2)
	end as perc_delta_avg_roas, 
	case 
		when sum_roas > sum_roas_window_prev_date then round((((sum_roas) - (sum_roas_window_prev_date)) / sum_roas_window_prev_date) * 100,2)
		else round(((-(sum_roas) + (sum_roas_window_prev_date)) / sum_roas_window_prev_date) * 100,2)
	end as perc_delta_sum_roas
from moving_sum_average where  date > date('2025-01-30');