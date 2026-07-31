-- filepath: dbt/models/public/daily_revenue_summary.sql
select
    date(transaction_timestamp) as revenue_date,
    sum(amount) as total_daily_revenue,
    currency
from {{ source('raw_data', 'transactions') }}
group by 1, 3