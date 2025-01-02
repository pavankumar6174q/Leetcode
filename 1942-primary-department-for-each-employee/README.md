<h2><a href="https://leetcode.com/problems/primary-department-for-each-employee">1942. Primary Department for Each Employee</a></h2><h3>Easy</h3><hr><p>Table: <code>Employee</code></p>

<pre>
+---------------+---------+
| Column Name   |  Type   |
+---------------+---------+
| employee_id   | int     |
| department_id | int     |
| primary_flag  | varchar |
+---------------+---------+
(employee_id, department_id) is the primary key (combination of columns with unique values) for this table.
employee_id is the id of the employee.
department_id is the id of the department to which the employee belongs.
primary_flag is an ENUM (category) of type (&#39;Y&#39;, &#39;N&#39;). If the flag is &#39;Y&#39;, the department is the primary department for the employee. If the flag is &#39;N&#39;, the department is not the primary.
</pre>

<p>&nbsp;</p>

<p>Employees can belong to multiple departments. When the employee joins other departments, they need to decide which department is their primary department. Note that when an employee belongs to only one department, their primary column is <code>&#39;N&#39;</code>.</p>

<p>Write a solution to report all the employees with their primary department. For employees who belong to one department, report their only department.</p>

<p>Return the result table in <strong>any order</strong>.</p>

<p>The&nbsp;result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Employee table:
+-------------+---------------+--------------+
| employee_id | department_id | primary_flag |
+-------------+---------------+--------------+
| 1           | 1             | N            |
| 2           | 1             | Y            |
| 2           | 2             | N            |
| 3           | 3             | N            |
| 4           | 2             | N            |
| 4           | 3             | Y            |
| 4           | 4             | N            |
+-------------+---------------+--------------+
<strong>Output:</strong> 
+-------------+---------------+
| employee_id | department_id |
+-------------+---------------+
| 1           | 1             |
| 2           | 1             |
| 3           | 3             |
| 4           | 3             |
+-------------+---------------+
<strong>Explanation:</strong> 
- The Primary department for employee 1 is 1.
- The Primary department for employee 2 is 1.
- The Primary department for employee 3 is 3.
- The Primary department for employee 4 is 3.
</pre>


### Query:
```sql
SELECT 
    employee_id, 
    department_id
FROM 
    Employee
WHERE 
    primary_flag = 'Y'

UNION

SELECT 
    employee_id, 
    department_id
FROM 
    Employee
GROUP BY 
    employee_id, department_id
HAVING 
    COUNT(employee_id) = 1;
```

---

### Explanation:

1. **Case 1: Employees with a Primary Department (`primary_flag = 'Y'`)**:
   - The first part of the query selects employees who have explicitly marked a department as their primary department:
     ```sql
     SELECT employee_id, department_id
     FROM Employee
     WHERE primary_flag = 'Y'
     ```

2. **Case 2: Employees Belonging to Only One Department**:
   - For employees with only one department, there is no primary flag set. These employees are included by grouping their records and identifying those who belong to a single department:
     ```sql
     SELECT employee_id, department_id
     FROM Employee
     GROUP BY employee_id, department_id
     HAVING COUNT(employee_id) = 1;
     ```

3. **Combining Results**:
   - The `UNION` combines results from both cases, ensuring no duplicates in the final output.

4. **Result Order**:
   - The result is returned in any order as required.

---

### Input Table Example:

**Employee Table**:
| employee_id | department_id | primary_flag |
|-------------|---------------|--------------|
| 1           | 1             | N            |
| 2           | 1             | Y            |
| 2           | 2             | N            |
| 3           | 3             | N            |
| 4           | 2             | N            |
| 4           | 3             | Y            |
| 4           | 4             | N            |

---

### Execution Steps:

1. **Primary Flag = 'Y'**:
   - Directly fetch records where `primary_flag = 'Y'`:
     | employee_id | department_id |
     |-------------|---------------|
     | 2           | 1             |
     | 4           | 3             |

2. **Employees in One Department**:
   - Identify employees with only one department:
     | employee_id | department_id |
     |-------------|---------------|
     | 1           | 1             |
     | 3           | 3             |

3. **Combined Results**:
   - Combine both sets:
     | employee_id | department_id |
     |-------------|---------------|
     | 1           | 1             |
     | 2           | 1             |
     | 3           | 3             |
     | 4           | 3             |

---

### Output:

**Result Table**:
| employee_id | department_id |
|-------------|---------------|
| 1           | 1             |
| 2           | 1             |
| 3           | 3             |
| 4           | 3             |

