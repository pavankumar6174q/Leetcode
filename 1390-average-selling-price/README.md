<h2><a href="https://leetcode.com/problems/average-selling-price">1390. Average Selling Price</a></h2><h3>Easy</h3><hr><p>Table: <code>Prices</code></p>

<pre>
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| start_date    | date    |
| end_date      | date    |
| price         | int     |
+---------------+---------+
(product_id, start_date, end_date) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the price of the product_id in the period from start_date to end_date.
For each product_id there will be no two overlapping periods. That means there will be no two intersecting periods for the same product_id.
</pre>

<p>&nbsp;</p>

<p>Table: <code>UnitsSold</code></p>

<pre>
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| purchase_date | date    |
| units         | int     |
+---------------+---------+
This table may contain duplicate rows.
Each row of this table indicates the date, units, and product_id of each product sold. 
</pre>

<p>&nbsp;</p>

<p>Write a solution to find the average selling price for each product. <code>average_price</code> should be <strong>rounded to 2 decimal places</strong>. If a product does not have any sold units, its average selling price is assumed to be 0.</p>

<p>Return the result table in <strong>any order</strong>.</p>

<p>The&nbsp;result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Prices table:
+------------+------------+------------+--------+
| product_id | start_date | end_date   | price  |
+------------+------------+------------+--------+
| 1          | 2019-02-17 | 2019-02-28 | 5      |
| 1          | 2019-03-01 | 2019-03-22 | 20     |
| 2          | 2019-02-01 | 2019-02-20 | 15     |
| 2          | 2019-02-21 | 2019-03-31 | 30     |
+------------+------------+------------+--------+
UnitsSold table:
+------------+---------------+-------+
| product_id | purchase_date | units |
+------------+---------------+-------+
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |
+------------+---------------+-------+
<strong>Output:</strong> 
+------------+---------------+
| product_id | average_price |
+------------+---------------+
| 1          | 6.96          |
| 2          | 16.96         |
+------------+---------------+
<strong>Explanation:</strong> 
Average selling price = Total Price of Product / Number of products sold.
Average selling price for product 1 = ((100 * 5) + (15 * 20)) / 115 = 6.96
Average selling price for product 2 = ((200 * 15) + (30 * 30)) / 230 = 16.96
</pre>


Here’s a step-by-step explanation of the query:

### Input Tables:
- **Prices**: Contains `product_id`, `start_date`, `end_date`, and `price` during specific time ranges.
- **UnitsSold**: Contains `product_id`, `purchase_date`, and the number of `units` sold on that date.

The goal is to calculate the **average selling price** for each product based on the prices and units sold during overlapping date ranges.

---

### Query Explanation:
#### **1. SELECT clause:**
```sql
select p.product_id,
IFNULL(round((sum(p.price * u.units)/sum(u.units)), 2),0) as average_price
```
- `p.product_id`: Selects the product ID.
- `sum(p.price * u.units)`: Calculates the total price for all units sold for each product. 
  - This is the product of the `price` from the `Prices` table and the `units` from the `UnitsSold` table.
- `sum(u.units)`: Calculates the total number of units sold for each product.
- `sum(p.price * u.units)/sum(u.units)`: Divides the total price by the total number of units to get the **average price**.
- `round(..., 2)`: Rounds the result to 2 decimal places.
- `IFNULL(..., 0)`: Handles cases where no units were sold by setting the `average_price` to `0`.

---

#### **2. FROM clause:**
```sql
from prices p
```
- Starts with the `Prices` table (`p`) as the base.

---

#### **3. JOIN clause:**
```sql
left join unitsSold u 
on p.product_id = u.product_id
and u.purchase_date between p.start_date and p.end_date
```
- Performs a **LEFT JOIN** between the `Prices` (`p`) and `UnitsSold` (`u`) tables on:
  1. Matching `product_id`.
  2. Ensuring the `purchase_date` from `UnitsSold` falls within the `start_date` and `end_date` of the `Prices` table.

This ensures that only the prices valid during the purchase dates are used in calculations.

---

#### **4. GROUP BY clause:**
```sql
group by 1
```
- Groups the data by `p.product_id` (the first column in the `SELECT` clause).
- Ensures that the calculations are performed separately for each product.

---

### Calculation Example:

#### **Product 1:**
1. **Units Sold and Prices:**
   - 100 units on `2019-02-25` at $5.
   - 15 units on `2019-03-01` at $20.
2. **Total Price:**
   - `(100 * 5) + (15 * 20) = 500 + 300 = 800`
3. **Total Units:**
   - `100 + 15 = 115`
4. **Average Price:**
   - `800 / 115 ≈ 6.96`

---

#### **Product 2:**
1. **Units Sold and Prices:**
   - 200 units on `2019-02-10` at $15.
   - 30 units on `2019-03-22` at $30.
2. **Total Price:**
   - `(200 * 15) + (30 * 30) = 3000 + 900 = 3900`
3. **Total Units:**
   - `200 + 30 = 230`
4. **Average Price:**
   - `3900 / 230 ≈ 16.96`

---

### Final Output:
```plaintext
+------------+---------------+
| product_id | average_price |
+------------+---------------+
| 1          | 6.96          |
| 2          | 16.96         |
+------------+---------------+
```
