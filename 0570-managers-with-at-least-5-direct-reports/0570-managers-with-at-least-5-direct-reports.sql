# Write your MySQL query statement below
SELECT e1.name from employee e1
join employee e2 
on e1.id = e2.managerid 
group by e2.managerid
having count(e2.managerid) >= 5
