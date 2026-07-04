-- filepath: dbt/models/public/daily_revenue_summary.sql
with raw_transactions as (
    select
        transaction_timestamp,
        amount
    from {{ source('raw', 'transactions') }}
),

daily_aggregation as (
    select
        date_trunc('day', transaction_timestamp)::date as revenue_date,
        sum(amount) as total_daily_revenue,
        count(*) as transaction_count
    from raw_transactions
    group by 1
)

select
    revenue_date,
    total_daily_revenue,
    transaction_count
from daily_aggregation
order by revenue_date desc