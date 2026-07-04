-- filepath: dbt/models/public/avg_events_per_user.sql
with base_events as (
    select
        user_id,
        event_value
    from {{ source('raw_sports', 'events') }}
)

select
    user_id,
    avg(event_value) as average_event_value
from base_events
group by 1
