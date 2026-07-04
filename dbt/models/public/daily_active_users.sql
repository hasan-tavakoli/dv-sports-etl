-- filepath: dbt/models/public/daily_active_users.sql
with raw_events as (
    select
        user_id,
        cast(event_timestamp as date) as activity_date
    from {{ source('sports', 'raw_user_events') }}
)

select
    activity_date,
    count(distinct user_id) as daily_active_users
from raw_events
group by 1