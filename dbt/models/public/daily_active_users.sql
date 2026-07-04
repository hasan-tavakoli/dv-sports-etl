-- filepath: dbt/models/public/daily_active_users.sql
with raw_events as (
    select
        cast(event_timestamp as date) as event_date,
        user_id
    from {{ source('sports', 'raw_user_events') }}
)

select
    event_date,
    count(distinct user_id) as daily_active_users
from raw_events
group by 1