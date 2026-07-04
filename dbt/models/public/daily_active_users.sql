-- filepath: dbt/models/public/daily_active_users.sql
with raw_events as (
    select
        date(event_timestamp) as activity_date,
        user_id
    from {{ source('sports_raw', 'user_events') }}
)

select
    activity_date,
    count(distinct user_id) as daily_active_users
from raw_events
group by 1