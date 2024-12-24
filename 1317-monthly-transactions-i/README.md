<h2><a href="https://leetcode.com/problems/monthly-transactions-i">1317. Monthly Transactions I</a></h2><h3>Medium</h3><hr><p>Table: <code>Transactions</code></p>

<pre>
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type [&quot;approved&quot;, &quot;declined&quot;].
</pre>

<p>&nbsp;</p>

<p>Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.</p>

<p>Return the result table in <strong>any order</strong>.</p>

<p>The query result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Transactions table:
+------+---------+----------+--------+------------+
| id   | country | state    | amount | trans_date |
+------+---------+----------+--------+------------+
| 121  | US      | approved | 1000   | 2018-12-18 |
| 122  | US      | declined | 2000   | 2018-12-19 |
| 123  | US      | approved | 2000   | 2019-01-01 |
| 124  | DE      | approved | 2000   | 2019-01-07 |
+------+---------+----------+--------+------------+
<strong>Output:</strong> 
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+
</pre>



Here’s a detailed explanation for the corrected query:

---

### **Query:**

```sql
SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') AS month, 
    country, 
    COUNT(id) AS trans_count, 
    SUM(IF(state = 'approved', 1, 0)) AS approved_count, 
    SUM(amount) AS trans_total_amount, 
    SUM(IF(state = 'approved', amount, 0)) AS approved_total_amount
FROM 
    transactions
GROUP BY 
    month, country;
```

---

### **Explanation:**

1. **`DATE_FORMAT(trans_date, '%Y-%m') AS month`**:
   - Extracts the `year` and `month` from the `trans_date` column in the format `YYYY-MM`.
   - Example: `2018-12-18` becomes `2018-12`.

---

2. **`country`**:
   - Groups data by the `country`.

---

3. **`COUNT(id) AS trans_count`**:
   - Counts the total number of transactions for each month and country.

   **Example Calculation**:
   - For `US` in `2018-12`, the transactions are:
     ```
     +------+---------+----------+--------+------------+
     | id   | country | state    | amount | trans_date |
     +------+---------+----------+--------+------------+
     | 121  | US      | approved | 1000   | 2018-12-18 |
     | 122  | US      | declined | 2000   | 2018-12-19 |
     +------+---------+----------+--------+------------+
     ```
     Total: `2`.

---

4. **`SUM(IF(state = 'approved', 1, 0)) AS approved_count`**:
   - Counts only the transactions where the `state` is `'approved'` by summing `1` for approved rows and `0` otherwise.

   **Example Calculation**:
   - For `US` in `2018-12`, approved transactions:
     ```
     +------+---------+----------+--------+------------+
     | id   | country | state    | amount | trans_date |
     +------+---------+----------+--------+------------+
     | 121  | US      | approved | 1000   | 2018-12-18 |
     +------+---------+----------+--------+------------+
     ```
     Approved count: `1`.

---

5. **`SUM(amount) AS trans_total_amount`**:
   - Sums up the `amount` for all transactions.

   **Example Calculation**:
   - For `US` in `2018-12`:
     ```
     +------+---------+----------+--------+------------+
     | id   | country | state    | amount | trans_date |
     +------+---------+----------+--------+------------+
     | 121  | US      | approved | 1000   | 2018-12-18 |
     | 122  | US      | declined | 2000   | 2018-12-19 |
     +------+---------+----------+--------+------------+
     ```
     Total amount: `1000 + 2000 = 3000`.

---

6. **`SUM(IF(state = 'approved', amount, 0)) AS approved_total_amount`**:
   - Sums up the `amount` only for approved transactions.

   **Example Calculation**:
   - For `US` in `2018-12`, approved transactions:
     ```
     +------+---------+----------+--------+------------+
     | id   | country | state    | amount | trans_date |
     +------+---------+----------+--------+------------+
     | 121  | US      | approved | 1000   | 2018-12-18 |
     +------+---------+----------+--------+------------+
     ```
     Approved total amount: `1000`.

---

7. **`GROUP BY month, country`**:
   - Groups the results by the extracted month and country.

---

### **Expected Output:**

For the given `Transactions` table:

| month   | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
|---------|---------|-------------|----------------|---------------------|-----------------------|
| 2018-12 | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01 | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01 | DE      | 1           | 1              | 2000               | 2000                  |

---


