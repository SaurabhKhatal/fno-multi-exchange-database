CREATE INDEX idx_trade_date_brin ON trades USING BRIN(trade_date);
CREATE INDEX idx_symbol ON instruments(symbol);
CREATE INDEX idx_open_int ON trades(open_int);