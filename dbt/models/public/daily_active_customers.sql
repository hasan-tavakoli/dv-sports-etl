-- filepath: dbt/models/public/daily_active_customers.sql
with source_data as (
    select
        date(bet_timestamp) as activity_date,
        customer_id
    from {{ source('raw_sports', 'bets') }}
)

select
    activity_date,
    count(distinct customer_id) as distinct_active_customers
from source_data
group by 1