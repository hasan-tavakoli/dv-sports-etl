-- filepath: dbt/models/public/daily_active_users.sql
with raw_events as (
    select
        event_timestamp,
        user_id
    from {{ source('sports_raw', 'user_events') }}
),

daily_aggregation as (
    select
        date_trunc(event_timestamp, day) as event_date,
        count(distinct user_id) as active_user_count
    from raw_events
    group by 1
)

select
    event_date,
    active_user_count
from daily_aggregation
order by event_date desc