-- filepath: dbt/models/public/daily_revenue_summary.sql
with raw_data as (
    select
        date_trunc('day', event_timestamp) as revenue_date,
        revenue_amount
    from {{ source('analytics', 'raw_events') }}
)

select
    revenue_date,
    sum(revenue_amount) as total_daily_revenue
from raw_data
group by 1