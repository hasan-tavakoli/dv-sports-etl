-- filepath: dbt/models/public/daily_active_customers.sql
select
    date_trunc('day', game_timestamp)::date as activity_date,
    count(distinct customer_id) as active_customer_count
from {{ source('raw_sports', 'games') }}
group by 1