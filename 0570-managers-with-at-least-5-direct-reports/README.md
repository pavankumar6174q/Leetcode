<h2><a href="https://leetcode.com/problems/managers-with-at-least-5-direct-reports">570. Managers with at Least 5 Direct Reports</a></h2><h3>Medium</h3><hr><p>Table: <code>Employee</code></p>

<pre>
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.
</pre>

<p>&nbsp;</p>

<p>Write a solution to find managers with at least <strong>five direct reports</strong>.</p>

<p>Return the result table in <strong>any order</strong>.</p>

<p>The result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Employee table:
+-----+-------+------------+-----------+
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
+-----+-------+------------+-----------+
<strong>Output:</strong> 
+------+
| name |
+------+
| John |
+------+
</pre>




Here’s a step-by-step visualization of the SQL query and how it processes the data:

---

### Step 1: The `Employee` Table

**Initial Data:**
```plaintext
+-----+-------+------------+-----------+
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
+-----+-------+------------+-----------+
```

---

### Step 2: Joining the Table with Itself

The query:
```sql
JOIN employee e2 ON e1.id = e2.managerid
```
Pairs each manager (`e1`) with their employees (`e2`).

**Result of the Join:**
```plaintext
+-------+------------+-----------+-------+------------+-----------+
| e1.id | e1.name    | e1.dept   | e2.id | e2.name    | e2.managerId |
+-------+------------+-----------+-------+------------+-----------+
| 101   | John       | A         | 102   | Dan        | 101       |
| 101   | John       | A         | 103   | James      | 101       |
| 101   | John       | A         | 104   | Amy        | 101       |
| 101   | John       | A         | 105   | Anne       | 101       |
| 101   | John       | A         | 106   | Ron        | 101       |
```

Here:
- Every row shows an employee (from `e2`) paired with their manager (from `e1`).

---

### Step 3: Grouping the Results

The query:
```sql
GROUP BY e2.managerid
```
Groups the rows based on the `managerId` from the second table (`e2`). Each group contains employees managed by a specific manager.

**Grouped Data:**
```plaintext
Group 1: e2.managerId = 101
+-------+------------+-----------+-------+------------+-----------+
| e1.id | e1.name    | e1.dept   | e2.id | e2.name    | e2.managerId |
+-------+------------+-----------+-------+------------+-----------+
| 101   | John       | A         | 102   | Dan        | 101       |
| 101   | John       | A         | 103   | James      | 101       |
| 101   | John       | A         | 104   | Amy        | 101       |
| 101   | John       | A         | 105   | Anne       | 101       |
| 101   | John       | A         | 106   | Ron        | 101       |
```

---

### Step 4: Counting Employees per Manager

The query:
```sql
HAVING COUNT(e2.managerid) >= 5
```
Counts how many employees each manager has and filters only those managers with 5 or more employees.

**Counted Data:**
```plaintext
Manager: John (id: 101) → Number of employees: 5
```

Since John manages 5 employees, he meets the criteria.

---

### Step 5: Selecting the Manager's Name

The query:
```sql
SELECT e1.name
```
Outputs the name of the manager who satisfies the condition.

**Final Result:**
```plaintext
+------+
| name |
+------+
| John |
+------+
```

---

