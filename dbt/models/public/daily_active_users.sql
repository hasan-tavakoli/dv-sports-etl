-- filepath: dbt/models/public/daily_active_users.sql
with raw_events as (
    select
        event_date,
        user_id
    from {{ source('sports_raw', 'user_events') }}
),

daily_aggregation as (
    select
        event_date,
        count(distinct user_id) as daily_active_users
    from raw_events
    group by 1
)

select
    event_date,
    daily_active_users
from daily_aggregation
order by event_date desc