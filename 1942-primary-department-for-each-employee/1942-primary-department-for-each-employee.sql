select employee_id, department_id
from employee
where primary_flag = 'Y'
UNION
select employee_id, department_id
from employee
group by 1
having count(employee_id) = 1 