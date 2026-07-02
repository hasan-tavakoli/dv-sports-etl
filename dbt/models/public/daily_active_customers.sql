-- filepath: dbt/models/public/daily_active_customers.sql
{{
  config(
    materialized='view'
  )
}}

select
    date(bet_timestamp) as bet_date,
    count(distinct customer_id) as daily_active_customer_count
from {{ source('raw_sports', 'bets') }}
group by 1