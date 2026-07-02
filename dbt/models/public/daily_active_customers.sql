-- filepath: dbt/models/public/daily_active_customers.sql
with source_bets as (
    select
        cast(bet_timestamp as date) as activity_date,
        customer_id
    from {{ source('raw_sports', 'bets') }}
)

select
    activity_date,
    count(distinct customer_id) as active_customer_count
from source_bets
group by 1