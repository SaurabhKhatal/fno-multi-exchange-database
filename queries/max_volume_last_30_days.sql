-- Maximum traded volume per symbol in last 30 days
-- Optimized for time-series queries

SELECT *
FROM (
    SELECT 
        i.symbol,
        e.exchange_name,
        t.trade_date,
        t.volume,
        RANK() OVER (
            PARTITION BY i.symbol
            ORDER BY t.volume DESC
        ) AS volume_rank
    FROM trades t
    JOIN expiries ex ON t.expiry_id = ex.expiry_id
    JOIN instruments i ON ex.instrument_id = i.instrument_id
    JOIN exchanges e ON i.exchange_id = e.exchange_id
    WHERE t.trade_date >= CURRENT_DATE - INTERVAL '30 days'
) ranked
WHERE volume_rank = 1
ORDER BY volume DESC;