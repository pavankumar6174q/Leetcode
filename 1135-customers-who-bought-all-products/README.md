<h2><a href="https://leetcode.com/problems/customers-who-bought-all-products">1135. Customers Who Bought All Products</a></h2><h3>Medium</h3><hr><p>Table: <code>Customer</code></p>

<pre>
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
This table may contain duplicates rows. 
<code>customer_id</code> is not NULL<code>.</code>
product_key is a foreign key (reference column) to <code>Product</code> table.
</pre>

<p>&nbsp;</p>

<p>Table: <code>Product</code></p>

<pre>
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key (column with unique values) for this table.
</pre>

<p>&nbsp;</p>

<p>Write a solution to report the customer ids from the <code>Customer</code> table that bought all the products in the <code>Product</code> table.</p>

<p>Return the result table in <strong>any order</strong>.</p>

<p>The&nbsp;result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Customer table:
+-------------+-------------+
| customer_id | product_key |
+-------------+-------------+
| 1           | 5           |
| 2           | 6           |
| 3           | 5           |
| 3           | 6           |
| 1           | 6           |
+-------------+-------------+
Product table:
+-------------+
| product_key |
+-------------+
| 5           |
| 6           |
+-------------+
<strong>Output:</strong> 
+-------------+
| customer_id |
+-------------+
| 1           |
| 3           |
+-------------+
<strong>Explanation:</strong> 
The customers who bought all the products (5 and 6) are customers with IDs 1 and 3.
</pre>


### Answer:

#### Query:
```sql
SELECT DISTINCT customer_id 
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM Product);
```

---

### **Step-by-Step Explanation**

#### 1. **Key Idea**:
We need to find customers (`customer_id`) who have purchased all the products listed in the `Product` table.

- **`Customer` table**: Contains which product was purchased by which customer.
- **`Product` table**: Lists all available products. Each customer must have bought all these products to be included in the result.

---

#### 2. **Subquery**:
```sql
(SELECT COUNT(product_key) FROM Product)
```
- **Purpose**: Counts the total number of unique products in the `Product` table.
- **Example**:
  - Given the `Product` table:
    | product_key |
    |-------------|
    | 5           |
    | 6           |
  - `SELECT COUNT(product_key)` would return `2`.

---

#### 3. **Grouping by Customer**:
```sql
GROUP BY customer_id
```
- Groups the `Customer` table by `customer_id` to analyze each customer's purchases independently.

---

#### 4. **Filtering Customers**:
```sql
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM Product)
```
- **Logic**:
  - `COUNT(DISTINCT product_key)` counts the number of unique products a customer has purchased.
  - The condition ensures that the number of unique products bought by the customer matches the total number of products in the `Product` table.
  - If a customer has purchased all the products, they satisfy the condition.

---

#### 5. **Final Result**:
- `SELECT DISTINCT customer_id` ensures the output only lists unique customer IDs who satisfy the condition.

---

### **Example Execution**

#### Input Tables:
**Customer Table**:
| customer_id | product_key |
|-------------|-------------|
| 1           | 5           |
| 2           | 6           |
| 3           | 5           |
| 3           | 6           |
| 1           | 6           |

**Product Table**:
| product_key |
|-------------|
| 5           |
| 6           |

---

#### Execution:

1. **Subquery Result**:
   - `SELECT COUNT(product_key) FROM Product`:
     - Counts the number of products.
     - Result: `2`.

2. **Grouped Customer Purchases**:
   - After grouping by `customer_id`:
     | customer_id | COUNT(DISTINCT product_key) |
     |-------------|-----------------------------|
     | 1           | 2                           |
     | 2           | 1                           |
     | 3           | 2                           |

3. **Filter Customers**:
   - Only customers with `COUNT(DISTINCT product_key) = 2`:
     | customer_id |
     |-------------|
     | 1           |
     | 3           |

---

#### Output:
| customer_id |
|-------------|
| 1           |
| 3           |

--- 

