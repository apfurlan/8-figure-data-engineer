
CREATE OR REPLACE FUNCTION metrics_in_range_date(
    p_start_date DATE,
    p_end_date DATE
)
RETURNS TABLE (
    start_date DATE,
    end_date DATE,
    avg_cac NUMERIC,
    avg_roas numeric,
    sum_cac NUMERIC,
    sum_roas numeric
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        date,
        AVG(a.spend/a.conversions) as avg_CAC,
        AVG(a.conversions*100/a.spend) as avg_ROAS,
        SUM(a.spend/a.conversions) as sum_CAC,
        SUM(a.conversions*100/a.spend) as sum_ROAS
    FROM postgres.public.ads_spend a
    WHERE a.date BETWEEN p_start_date AND p_end_date
	group by a.date
    ORDER BY a.date;
END;
$$;

select * from  metrics_in_range_date('2025-03-22','2025-06-12')