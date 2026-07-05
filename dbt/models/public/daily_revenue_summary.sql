-- filepath: dbt/models/public/daily_revenue_summary.sql
select
    date_trunc(transaction_timestamp, day) as revenue_date,
    sum(amount) as total_daily_revenue,
    count(distinct user_id) as daily_active_users
from {{ source('raw_data', 'transactions') }}
group by 1