-- Cross-exchange comparison:
-- Average settle price for GOLD futures (MCX) vs equity index futures (NSE)

SELECT 
    e.exchange_name,
    i.symbol,
    AVG(t.settle_pr) AS avg_settle_price
FROM trades t
JOIN expiries ex ON t.expiry_id = ex.expiry_id
JOIN instruments i ON ex.instrument_id = i.instrument_id
JOIN exchanges e ON i.exchange_id = e.exchange_id
WHERE 
    (i.symbol ILIKE '%GOLD%' AND e.exchange_name = 'MCX')
    OR
    (i.symbol IN ('NIFTY', 'BANKNIFTY') 
     AND i.instrument_type LIKE 'FUT%' 
     AND e.exchange_name = 'NSE')
GROUP BY e.exchange_name, i.symbol
ORDER BY e.exchange_name;