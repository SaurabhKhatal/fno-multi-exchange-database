CREATE TABLE exchanges (
    exchange_id SERIAL PRIMARY KEY,
    exchange_name VARCHAR(10) UNIQUE NOT NULL
);

CREATE TABLE instruments (
    instrument_id SERIAL PRIMARY KEY,
    symbol VARCHAR(50) NOT NULL,
    instrument_type VARCHAR(20) NOT NULL,
    exchange_id INT REFERENCES exchanges(exchange_id),
    UNIQUE(symbol, instrument_type, exchange_id)
);

CREATE TABLE expiries (
    expiry_id SERIAL PRIMARY KEY,
    instrument_id INT REFERENCES instruments(instrument_id),
    expiry_dt DATE NOT NULL,
    strike_pr NUMERIC(12,2),
    option_typ VARCHAR(5),
    UNIQUE(instrument_id, expiry_dt, strike_pr, option_typ)
);

CREATE TABLE trades (
    trade_id BIGSERIAL,
    expiry_id INT REFERENCES expiries(expiry_id),
    trade_date DATE NOT NULL,
    open_pr NUMERIC(12,2),
    high_pr NUMERIC(12,2),
    low_pr NUMERIC(12,2),
    close_pr NUMERIC(12,2),
    settle_pr NUMERIC(12,2),
    volume BIGINT,
    open_int BIGINT,
    chg_in_oi BIGINT,
    PRIMARY KEY (trade_id, trade_date)
);