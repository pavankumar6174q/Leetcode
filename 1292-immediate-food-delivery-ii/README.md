<h2><a href="https://leetcode.com/problems/immediate-food-delivery-ii">1292. Immediate Food Delivery II</a></h2><h3>Medium</h3><hr><p>Table: <code>Delivery</code></p>

<pre>
+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the column of unique values of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).
</pre>

<p>&nbsp;</p>

<p>If the customer&#39;s preferred delivery date is the same as the order date, then the order is called <strong>immediate;</strong> otherwise, it is called <strong>scheduled</strong>.</p>

<p>The <strong>first order</strong> of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.</p>

<p>Write a solution to find the percentage of immediate orders in the first orders of all customers, <strong>rounded to 2 decimal places</strong>.</p>

<p>The&nbsp;result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 2           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-12                  |
| 4           | 3           | 2019-08-24 | 2019-08-24                  |
| 5           | 3           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
| 7           | 4           | 2019-08-09 | 2019-08-09                  |
+-------------+-------------+------------+-----------------------------+
<strong>Output:</strong> 
+----------------------+
| immediate_percentage |
+----------------------+
| 50.00                |
+----------------------+
<strong>Explanation:</strong> 
The customer id 1 has a first order with delivery id 1 and it is scheduled.
The customer id 2 has a first order with delivery id 2 and it is immediate.
The customer id 3 has a first order with delivery id 5 and it is scheduled.
The customer id 4 has a first order with delivery id 7 and it is immediate.
Hence, half the customers have immediate first orders.
</pre>



Here's a detailed breakdown of the query provided:

---

### **Goal**
The task is to calculate the percentage of **immediate orders** among the **first orders** of all customers, rounded to two decimal places. An order is considered immediate if the customer's preferred delivery date matches the order date.

---

### **Query:**

```sql
SELECT 
    ROUND(SUM(IF(min_date = min_delivery_date, 1, 0) * 100) / COUNT(min_date), 2) AS immediate_percentage
FROM (
    SELECT 
        customer_id,
        MIN(order_date) AS min_date,
        MIN(customer_pref_delivery_date) AS min_delivery_date
    FROM 
        delivery
    GROUP BY 
        customer_id
) AS new_table;
```

---

### **Step-by-Step Explanation:**

#### 1. **Inner Query:**
   ```sql
   SELECT 
       customer_id,
       MIN(order_date) AS min_date,
       MIN(customer_pref_delivery_date) AS min_delivery_date
   FROM 
       delivery
   GROUP BY 
       customer_id;
   ```
   - **Purpose**: Identify the **first order** for each customer.
   - **Logic**:
     - `MIN(order_date)` fetches the earliest order date (`min_date`) for each `customer_id`.
     - `MIN(customer_pref_delivery_date)` fetches the corresponding preferred delivery date for that first order (`min_delivery_date`).
   - **Result Example** (based on the input data):
     | customer_id | min_date   | min_delivery_date |
     |-------------|------------|-------------------|
     | 1           | 2019-08-01 | 2019-08-02        |
     | 2           | 2019-08-02 | 2019-08-02        |
     | 3           | 2019-08-21 | 2019-08-22        |
     | 4           | 2019-08-09 | 2019-08-09        |

---

#### 2. **Outer Query:**
   ```sql
   SELECT 
       ROUND(SUM(IF(min_date = min_delivery_date, 1, 0) * 100) / COUNT(min_date), 2) AS immediate_percentage
   FROM 
       ( ... ) AS new_table;
   ```
   - **Purpose**: Calculate the percentage of immediate orders among all first orders.

   - **Key Components**:
     - **`IF(min_date = min_delivery_date, 1, 0)`**:
       - Compares the earliest `order_date` (`min_date`) with the preferred delivery date (`min_delivery_date`).
       - Returns `1` for immediate orders and `0` otherwise.
     - **`SUM(IF(...)) * 100`**:
       - Counts the total number of immediate orders and multiplies by 100 to prepare for percentage calculation.
     - **`COUNT(min_date)`**:
       - Counts the total number of customers (or first orders).
     - **`ROUND(..., 2)`**:
       - Rounds the final percentage to two decimal places.

   - **Calculation**:
     - Immediate orders:
       - Customer 2 (2019-08-02 = 2019-08-02)
       - Customer 4 (2019-08-09 = 2019-08-09)
       - Total immediate orders = 2.
     - Total customers = 4.
     - Immediate percentage = `(2 / 4) * 100 = 50.00`.

   - **Final Result**:
     | immediate_percentage |
     |-----------------------|
     | 50.00                |

---

### **Output**
The query calculates the percentage of immediate first orders among all customers and outputs the result rounded to two decimal places.

| immediate_percentage |
|-----------------------|
| 50.00                |

---


