-- filepath: dbt/models/public/weekly_top_players.sql
with player_stats as (
    select
        player_id,
        player_name,
        sport_type,
        points_scored,
        game_date
    from {{ source('sports_raw', 'game_performance') }}
    where game_date >= date_sub(current_date(), interval 7 day)
),

aggregated_stats as (
    select
        player_id,
        player_name,
        sport_type,
        sum(points_scored) as total_weekly_points,
        count(*) as games_played
    from player_stats
    group by 1, 2, 3
)

select
    *,
    rank() over (partition by sport_type order by total_weekly_points desc) as rank_in_sport
from aggregated_stats