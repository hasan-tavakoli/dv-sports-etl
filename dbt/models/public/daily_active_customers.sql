-- filepath: dbt/models/public/daily_active_customers.sql
select
    date_trunc('day', game_time)::date as activity_date,
    count(distinct customer_id) as daily_active_customers
from {{ source('raw_sports', 'games') }}
group by 1