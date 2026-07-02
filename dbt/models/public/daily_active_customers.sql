-- filepath: dbt/models/public/daily_active_customers.sql
with source_data as (
    select
        date(bet_timestamp) as bet_date,
        customer_id
    from {{ source('raw_sports', 'bets') }}
)

select
    bet_date,
    count(distinct customer_id) as active_customer_count
from source_data
group by 1