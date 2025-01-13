# Write your MySQL query statement below
select p.product_name, sum(r.unit) as unit from products p
join orders r Using (product_id)
where year(r.order_date) = '2020' and month(r.order_date) = '02'
group by p.product_id
having sum(r.unit) >=100;
