# Write your MySQL query statement below
select w1.id from weather w1
join weather w2 
on subdate(w1.recordDate, 1) = w2.recordDate
where w1.temperature > w2.temperature


