-- filepath: dbt/models/public/daily_revenue_summary.sql
with source_data as (
    select
        date_trunc('day', transaction_timestamp) as revenue_date,
        amount
    from {{ source('analytics_raw', 'transactions') }}
)

select
    revenue_date,
    sum(amount) as total_daily_revenue
from source_data
group by 1