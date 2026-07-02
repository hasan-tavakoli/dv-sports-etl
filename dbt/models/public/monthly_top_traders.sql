-- filepath: dbt/models/public/monthly_top_traders.sql
with base_trades as (
    select
        trader_id,
        date_trunc(trade_timestamp, month) as trade_month,
        trade_id
    from {{ source('raw_bi', 'trades') }}
)

select
    trade_month,
    trader_id,
    count(trade_id) as total_trades
from base_trades
group by 1, 2