<h2><a href="https://leetcode.com/problems/project-employees-i">1161. Project Employees I</a></h2><h3>Easy</h3><hr><p>Table: <code>Project</code></p>

<pre>
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to <code>Employee</code> table.
Each row of this table indicates that the employee with employee_id is working on the project with project_id.
</pre>

<p>&nbsp;</p>

<p>Table: <code>Employee</code></p>

<pre>
+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key of this table. It&#39;s guaranteed that experience_years is not NULL.
Each row of this table contains information about one employee.
</pre>

<p>&nbsp;</p>

<p>Write an SQL query that reports the <strong>average</strong> experience years of all the employees for each project, <strong>rounded to 2 digits</strong>.</p>

<p>Return the result table in <strong>any order</strong>.</p>

<p>The query result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Project table:
+-------------+-------------+
| project_id  | employee_id |
+-------------+-------------+
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+
Employee table:
+-------------+--------+------------------+
| employee_id | name   | experience_years |
+-------------+--------+------------------+
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 1                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+
<strong>Output:</strong> 
+-------------+---------------+
| project_id  | average_years |
+-------------+---------------+
| 1           | 2.00          |
| 2           | 2.50          |
+-------------+---------------+
<strong>Explanation:</strong> The average experience years for the first project is (3 + 2 + 1) / 3 = 2.00 and for the second project is (3 + 2) / 2 = 2.50
</pre>



Got it! Let’s make sure the tables are represented in a **GitHub Markdown-compatible format** for easy readability and pasting.

---

### **Input Tables**

#### **Project Table**
```markdown
| project_id | employee_id |
|------------|-------------|
| 1          | 1           |
| 1          | 2           |
| 1          | 3           |
| 2          | 1           |
| 2          | 4           |
```

#### **Employee Table**
```markdown
| employee_id | name   | experience_years |
|-------------|--------|------------------|
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 1                |
| 4           | Doe    | 2                |
```

---

### **Query**

```sql
SELECT p.project_id,  
       ROUND(AVG(e.experience_years), 2) AS average_years
FROM project p 
JOIN employee e 
ON p.employee_id = e.employee_id
GROUP BY p.project_id;
```

---

### **Step-by-Step Execution**

#### **Step 1: Join the Tables**
The `JOIN` combines records from both tables where `project.employee_id = employee.employee_id`.

Result after the join:
```markdown
| project_id | employee_id | name   | experience_years |
|------------|-------------|--------|------------------|
| 1          | 1           | Khaled | 3                |
| 1          | 2           | Ali    | 2                |
| 1          | 3           | John   | 1                |
| 2          | 1           | Khaled | 3                |
| 2          | 4           | Doe    | 2                |
```

---

#### **Step 2: Group by `project_id`**
The `GROUP BY` groups records by `project_id` for aggregate calculations:
- For `project_id = 1`: Employees 1, 2, and 3.
- For `project_id = 2`: Employees 1 and 4.

---

#### **Step 3: Calculate Average Experience**
Use `AVG()` to calculate the average `experience_years` for each `project_id`:
- For `project_id = 1`:
  \[
  \text{Average} = \frac{(3 + 2 + 1)}{3} = 2.00
  \]
- For `project_id = 2`:
  \[
  \text{Average} = \frac{(3 + 2)}{2} = 2.50
  \]

---

### **Output Table**
```markdown
| project_id | average_years |
|------------|---------------|
| 1          | 2.00          |
| 2          | 2.50          |
```
