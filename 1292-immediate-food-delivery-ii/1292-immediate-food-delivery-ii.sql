select round(sum(if(min_date = min_delivery_date, 1, 0)*100)/count(min_date),2)as immediate_percentage
from (
    select customer_id,
    min(order_date) as min_date,
    min(customer_pref_delivery_date) as min_delivery_date
    from delivery
    group by 1
) as new_table
