<h2><a href="https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee">1882. The Number of Employees Which Report to Each Employee</a></h2><h3>Easy</h3><hr><p>Table: <code>Employees</code></p>

<pre>
+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |
+-------------+----------+
employee_id is the column with unique values for this table.
This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null). 
</pre>

<p>&nbsp;</p>

<p>For this problem, we will consider a <strong>manager</strong> an employee who has at least 1 other employee reporting to them.</p>

<p>Write a solution to report the ids and the names of all <strong>managers</strong>, the number of employees who report <strong>directly</strong> to them, and the average age of the reports rounded to the nearest integer.</p>

<p>Return the result table ordered by <code>employee_id</code>.</p>

<p>The&nbsp;result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Employees table:
+-------------+---------+------------+-----+
| employee_id | name    | reports_to | age |
+-------------+---------+------------+-----+
| 9           | Hercy   | null       | 43  |
| 6           | Alice   | 9          | 41  |
| 4           | Bob     | 9          | 36  |
| 2           | Winston | null       | 37  |
+-------------+---------+------------+-----+
<strong>Output:</strong> 
+-------------+-------+---------------+-------------+
| employee_id | name  | reports_count | average_age |
+-------------+-------+---------------+-------------+
| 9           | Hercy | 2             | 39          |
+-------------+-------+---------------+-------------+
<strong>Explanation:</strong> Hercy has 2 people report directly to him, Alice and Bob. Their average age is (41+36)/2 = 38.5, which is 39 after rounding it to the nearest integer.
</pre>

<p><strong class="example">Example 2:</strong></p>

<pre>
<strong>Input:</strong> 
Employees table:
+-------------+---------+------------+-----+ 
| employee_id | name &nbsp; &nbsp;| reports_to | age |
|-------------|---------|------------|-----|
| 1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Michael | null &nbsp; &nbsp; &nbsp; | 45 &nbsp;|
| 2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Alice &nbsp; | 1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| 38 &nbsp;|
| 3 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Bob &nbsp; &nbsp; | 1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| 42 &nbsp;|
| 4 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Charlie | 2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| 34 &nbsp;|
| 5 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | David &nbsp; | 2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| 40 &nbsp;|
| 6 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Eve &nbsp; &nbsp; | 3 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| 37 &nbsp;|
| 7 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Frank &nbsp; | null &nbsp; &nbsp; &nbsp; | 50 &nbsp;|
| 8 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Grace &nbsp; | null &nbsp; &nbsp; &nbsp; | 48 &nbsp;|
+-------------+---------+------------+-----+ 
<strong>Output:</strong> 
+-------------+---------+---------------+-------------+
| employee_id | name &nbsp; &nbsp;| reports_count | average_age |
| ----------- | ------- | ------------- | ----------- |
| 1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Michael | 2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | 40 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|
| 2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Alice &nbsp; | 2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | 37 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|
| 3 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Bob &nbsp; &nbsp; | 1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | 37 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|
+-------------+---------+---------------+-------------+

</pre>




### Query:
```sql
SELECT 
    e1.employee_id, 
    e1.name,
    COUNT(e2.employee_id) AS reports_count,
    ROUND(AVG(e2.age)) AS average_age
FROM 
    Employees e1
JOIN 
    Employees e2 
ON 
    e1.employee_id = e2.reports_to
GROUP BY 
    e1.employee_id, e1.name
ORDER BY 
    e1.employee_id;
```

---

### Explanation:

1. **Joining Tables**:
   - The query joins the `Employees` table to itself using the condition:
     ```sql
     e1.employee_id = e2.reports_to
     ```
   - This means each `e1` record represents a manager, and each `e2` record represents an employee reporting to that manager.

---

2. **Counting Reports**:
   - `COUNT(e2.employee_id)` counts the number of employees directly reporting to each manager.

---

3. **Calculating Average Age**:
   - `AVG(e2.age)` calculates the average age of the employees reporting to each manager.
   - `ROUND(AVG(e2.age))` rounds the average age to the nearest integer.

---

4. **Grouping Results**:
   - `GROUP BY e1.employee_id, e1.name` ensures that the counts and averages are calculated for each unique manager.

---

5. **Ordering Results**:
   - `ORDER BY e1.employee_id` arranges the output by the manager's ID in ascending order.

---

### Input Table Example:

**Employees Table**:
| employee_id | name    | reports_to | age |
|-------------|---------|------------|-----|
| 9           | Hercy   | null       | 43  |
| 6           | Alice   | 9          | 41  |
| 4           | Bob     | 9          | 36  |
| 2           | Winston | null       | 37  |

---

### Execution:

1. **Join Results**:
   - Matches managers (`e1`) with their direct reports (`e2`):
     | e1.employee_id | e1.name | e2.employee_id | e2.age |
     |----------------|---------|----------------|--------|
     | 9              | Hercy  | 6              | 41     |
     | 9              | Hercy  | 4              | 36     |

2. **Grouped Results**:
   - After grouping by `e1.employee_id`:
     | e1.employee_id | e1.name | COUNT(e2.employee_id) | AVG(e2.age) |
     |----------------|---------|-----------------------|-------------|
     | 9              | Hercy  | 2                     | 38.5        |

3. **Final Result**:
   - Rounded average age and ordered output:
     | employee_id | name  | reports_count | average_age |
     |-------------|-------|---------------|-------------|
     | 9           | Hercy | 2             | 39          |

---

### Output:

For the given example:

| employee_id | name    | reports_count | average_age |
|-------------|---------|---------------|-------------|
| 9           | Hercy   | 2             | 39          |


