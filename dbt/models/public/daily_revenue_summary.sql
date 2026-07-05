-- filepath: dbt/models/public/daily_revenue_summary.sql
with raw_transactions as (
    select
        transaction_timestamp,
        amount
    from {{ source('analytics', 'raw_transactions') }}
)

select
    date(transaction_timestamp) as revenue_date,
    sum(amount) as total_daily_revenue
from raw_transactions
group by 1