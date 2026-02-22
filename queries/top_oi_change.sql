-- Top 10 symbols by total Open Interest (OI) change across exchanges

WITH oi_calc AS (
    SELECT 
        i.symbol,
        e.exchange_name,
        t.trade_date,
        t.open_int,
        LAG(t.open_int) OVER (
            PARTITION BY i.symbol, e.exchange_name
            ORDER BY t.trade_date
        ) AS prev_oi
    FROM trades t
    JOIN expiries ex ON t.expiry_id = ex.expiry_id
    JOIN instruments i ON ex.instrument_id = i.instrument_id
    JOIN exchanges e ON i.exchange_id = e.exchange_id
)

SELECT 
    symbol,
    exchange_name,
    SUM(open_int - prev_oi) AS total_oi_change
FROM oi_calc
WHERE prev_oi IS NOT NULL
GROUP BY symbol, exchange_name
ORDER BY total_oi_change DESC
LIMIT 10;