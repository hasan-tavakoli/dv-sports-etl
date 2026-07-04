-- filepath: dbt/models/public/stg_sports_clean.sql
{{
    config(
        materialized='table',
        database='dv-dev-eu-w1-sports-data',
        schema='stage'
    )
}}

with source_data as (
    select *
    from {{ source('sports_raw', 'old_sports_staging') }}
)

select
    cast(id as string) as sports_id,
    cast(event_name as string) as event_name,
    cast(event_date as timestamp) as event_timestamp,
    cast(venue as string) as venue_location,
    current_timestamp() as processed_at
from source_data
where id is not null