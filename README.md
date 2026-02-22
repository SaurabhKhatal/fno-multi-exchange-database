Project Overview

This project implements a normalized (3NF) relational database for high-volume Futures & Options data across NSE, BSE, and MCX.

Design Rationale

The schema separates Exchanges, Instruments, Expiries, and Trades to eliminate redundancy and ensure data integrity. Strike price and expiry are stored separately from trade records to avoid duplication across millions of rows.

Why Not Star Schema?

A star schema was avoided because:

The workload is ingestion-heavy (transactional)

Frequent updates to open interest

High-frequency data insertions

Normalized schema ensures better write performance and consistency

Scalability

BRIN indexes for time-series optimization

Range partitioning by trade_date

Supports 10M+ rows

Suitable for HFT ingestion and quant analytics