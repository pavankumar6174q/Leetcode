select round(sum(player_logins)/count(distinct player_id),2) as fraction
from 
(
    select player_id, 
    datediff(event_date, min(event_date) over(partition by player_id)) = 1 as player_logins
    from activity
) as logins