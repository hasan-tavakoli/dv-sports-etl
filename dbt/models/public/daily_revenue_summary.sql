-- filepath: dbt/models/public/daily_revenue_summary.sql
with raw_transactions as (
    select
        transaction_date,
        transaction_amount
    from {{ source('analytics', 'raw_transactions') }}
)

select
    date_trunc('day', transaction_date)::date as revenue_date,
    sum(transaction_amount) as total_daily_revenue
from raw_transactions
group by 1