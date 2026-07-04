-- filepath: dbt/models/public/daily_active_users.sql
with raw_events as (
    select
        cast(event_timestamp as date) as activity_date,
        user_id
    from {{ source('sports', 'raw_user_events') }}
),

daily_aggregation as (
    select
        activity_date,
        count(distinct user_id) as daily_active_users
    from raw_events
    group by 1
)

select
    activity_date,
    daily_active_users
from daily_aggregation
order by activity_date desc