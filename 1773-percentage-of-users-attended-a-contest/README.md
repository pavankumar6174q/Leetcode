<h2><a href="https://leetcode.com/problems/percentage-of-users-attended-a-contest">1773. Percentage of Users Attended a Contest</a></h2><h3>Easy</h3><hr><p>Table: <code>Users</code></p>

<pre>
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| user_name   | varchar |
+-------------+---------+
user_id is the primary key (column with unique values) for this table.
Each row of this table contains the name and the id of a user.
</pre>

<p>&nbsp;</p>

<p>Table: <code>Register</code></p>

<pre>
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| contest_id  | int     |
| user_id     | int     |
+-------------+---------+
(contest_id, user_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id of a user and the contest they registered into.
</pre>

<p>&nbsp;</p>

<p>Write a solution to find the percentage of the users registered in each contest rounded to <strong>two decimals</strong>.</p>

<p>Return the result table ordered by <code>percentage</code> in <strong>descending order</strong>. In case of a tie, order it by <code>contest_id</code> in <strong>ascending order</strong>.</p>

<p>The result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Users table:
+---------+-----------+
| user_id | user_name |
+---------+-----------+
| 6       | Alice     |
| 2       | Bob       |
| 7       | Alex      |
+---------+-----------+
Register table:
+------------+---------+
| contest_id | user_id |
+------------+---------+
| 215        | 6       |
| 209        | 2       |
| 208        | 2       |
| 210        | 6       |
| 208        | 6       |
| 209        | 7       |
| 209        | 6       |
| 215        | 7       |
| 208        | 7       |
| 210        | 2       |
| 207        | 2       |
| 210        | 7       |
+------------+---------+
<strong>Output:</strong> 
+------------+------------+
| contest_id | percentage |
+------------+------------+
| 208        | 100.0      |
| 209        | 100.0      |
| 210        | 100.0      |
| 215        | 66.67      |
| 207        | 33.33      |
+------------+------------+
<strong>Explanation:</strong> 
All the users registered in contests 208, 209, and 210. The percentage is 100% and we sort them in the answer table by contest_id in ascending order.
Alice and Alex registered in contest 215 and the percentage is ((2/3) * 100) = 66.67%
Bob registered in contest 207 and the percentage is ((1/3) * 100) = 33.33%
</pre>






Let's break this query and its logic step by step, just like before!

---

### Tables Overview

1. **Users Table**:
   Contains information about all users who can potentially register for contests.
   ```plaintext
   +---------+-----------+
   | user_id | user_name |
   +---------+-----------+
   | 6       | Alice     |
   | 2       | Bob       |
   | 7       | Alex      |
   +---------+-----------+
   ```
   **Total number of users**: 3 (Alice, Bob, Alex).

2. **Register Table**:
   Tracks which users registered for which contests.
   ```plaintext
   +------------+---------+
   | contest_id | user_id |
   +------------+---------+
   | 215        | 6       |
   | 209        | 2       |
   | 208        | 2       |
   | 210        | 6       |
   | 208        | 6       |
   | 209        | 7       |
   | 209        | 6       |
   | 215        | 7       |
   | 208        | 7       |
   | 210        | 2       |
   | 207        | 2       |
   | 210        | 7       |
   +------------+---------+
   ```

---

### Objective

For each contest, calculate:
- **Percentage of unique users** registered for that contest, relative to the total number of users.
- Sort the results by `percentage DESC` (higher percentages first) and then `contest_id ASC` (to break ties).

---

### Query Explanation

#### Query:
```sql
SELECT contest_id, 
       ROUND(COUNT(DISTINCT user_id) * 100 / (SELECT COUNT(user_id) FROM users), 2) AS percentage
FROM register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id;
```

---

### Step-by-Step Breakdown

#### 1. `COUNT(DISTINCT user_id)`
This counts the **unique users** who registered for each `contest_id`.

**Example**:
For contest `208`, the registered users are:
- `2`, `6`, `7` (all distinct).
So, `COUNT(DISTINCT user_id) = 3`.

---

#### 2. `(SELECT COUNT(user_id) FROM users)`
This is a subquery to calculate the **total number of users** in the `Users` table.

**Result**: `COUNT(user_id) = 3` (Alice, Bob, Alex).

---

#### 3. `COUNT(DISTINCT user_id) * 100 / (SELECT COUNT(user_id) FROM users)`
This calculates the **percentage** of unique users registered for each contest.

**Example**:
For contest `208`:
\[
\text{Percentage} = \frac{3 \times 100}{3} = 100.0\%
\]

For contest `215` (users `6` and `7` registered):
\[
\text{Percentage} = \frac{2 \times 100}{3} = 66.67\%
\]

For contest `207` (user `2` registered):
\[
\text{Percentage} = \frac{1 \times 100}{3} = 33.33\%
\]

---

#### 4. `GROUP BY contest_id`
This groups the results by `contest_id`, so the percentage is calculated for each contest separately.

---

#### 5. `ORDER BY percentage DESC, contest_id`
This sorts the contests:
1. By percentage in descending order (higher percentages come first).
2. By contest ID in ascending order to break ties.

---

### Final Output

**Step-by-step calculations**:
| Contest ID | Unique Users | Percentage |
|------------|--------------|------------|
| 208        | 3            | 100.00%    |
| 209        | 3            | 100.00%    |
| 210        | 3            | 100.00%    |
| 215        | 2            | 66.67%     |
| 207        | 1            | 33.33%     |

**Sorted Result**:
```plaintext
+------------+------------+
| contest_id | percentage |
+------------+------------+
| 208        | 100.0      |
| 209        | 100.0      |
| 210        | 100.0      |
| 215        | 66.67      |
| 207        | 33.33      |
+------------+------------+
```

---

### Key Points to Remember:
1. **`COUNT(DISTINCT user_id)`** ensures we only count unique users per contest.
2. The **subquery** finds the total number of users for calculating the percentage.
3. The **`ROUND` function** ensures the percentage is rounded to 2 decimal places for clarity.
