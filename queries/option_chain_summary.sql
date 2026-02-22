-- Option Chain Summary
-- Grouped by expiry date and strike price
-- Calculates total traded volume (implied liquidity)

SELECT 
    ex.expiry_dt,
    ex.strike_pr,
    ex.option_typ,
    SUM(t.volume) AS implied_volume
FROM trades t
JOIN expiries ex ON t.expiry_id = ex.expiry_id
JOIN instruments i ON ex.instrument_id = i.instrument_id
WHERE i.instrument_type LIKE 'OPT%'
GROUP BY ex.expiry_dt, ex.strike_pr, ex.option_typ
ORDER BY ex.expiry_dt, ex.strike_pr;