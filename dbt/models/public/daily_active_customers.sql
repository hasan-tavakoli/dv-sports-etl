-- filepath: dbt/models/public/daily_active_customers.sql
with base_games as (
    select
        cast(game_timestamp as date) as activity_date,
        customer_id
    from {{ source('raw_sports', 'games') }}
)

select
    activity_date,
    count(distinct customer_id) as daily_active_customer_count
from base_games
group by 1