-- 7-day rolling standard deviation of close prices for NIFTY options (NSE)

SELECT 
    t.trade_date,
    STDDEV(t.close_pr) OVER (
        ORDER BY t.trade_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS rolling_volatility
FROM trades t
JOIN expiries ex ON t.expiry_id = ex.expiry_id
JOIN instruments i ON ex.instrument_id = i.instrument_id
JOIN exchanges e ON i.exchange_id = e.exchange_id
WHERE i.symbol = 'NIFTY'
  AND i.instrument_type LIKE 'OPT%'
  AND e.exchange_name = 'NSE'
ORDER BY t.trade_date;