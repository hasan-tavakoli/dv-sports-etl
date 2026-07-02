-- filepath: dbt/models/public/stg_sports__games.sql
select
    game_id,
    game_date,
    home_team_id,
    away_team_id,
    home_score,
    away_score,
    venue_name,
    status
from {{ source('raw_sports', 'games') }}