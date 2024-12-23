# Write your MySQL query statement below
select p.product_id,
IFNULL(round((sum(p.price * u.units)/sum(u.units)), 2),0) as average_price
from prices p
left join unitsSold u on p.product_id = u.product_id
and u.purchase_date between p.start_date and p.end_date
group by 1 


