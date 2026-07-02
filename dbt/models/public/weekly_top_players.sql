-- filepath: dbt/models/public/weekly_top_players.sql
with base_bets as (
    select
        player_id,
        date_trunc(bet_timestamp, week) as bet_week,
        bet_id
    from {{ source('raw_sports', 'bets') }}
)

select
    player_id,
    bet_week,
    count(bet_id) as total_bets
from base_bets
group by 1, 2