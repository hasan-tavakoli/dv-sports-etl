-- filepath: dbt/models/public/avg_bet_per_player.sql
with base_bets as (
    select
        player_id,
        bet_amount
    from {{ source('raw_sports', 'bets') }}
)

select
    player_id,
    avg(bet_amount) as average_bet_amount
from base_bets
group by 1