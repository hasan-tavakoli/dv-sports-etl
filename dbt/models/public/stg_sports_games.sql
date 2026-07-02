-- filepath: dbt/models/public/stg_sports_games.sql
select
    game_id,
    game_date,
    home_team_id,
    away_team_id,
    home_score,
    away_score,
    venue_name,
    league_name
from {{ source('raw_sports', 'games') }}