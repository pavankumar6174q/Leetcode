select contest_id, 
round(count(distinct user_id)*100/ (select count(*) from users) ,2)as percentage
from register
group by 1
order by percentage desc, contest_id 