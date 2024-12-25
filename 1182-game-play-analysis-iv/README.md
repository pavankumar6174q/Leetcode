<h2><a href="https://leetcode.com/problems/game-play-analysis-iv">1182. Game Play Analysis IV</a></h2><h3>Medium</h3><hr><p>Table: <code>Activity</code></p>

<pre>
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
</pre>

<p>&nbsp;</p>

<p>Write a&nbsp;solution&nbsp;to report the <strong>fraction</strong> of players that logged in again on the day after the day they first logged in, <strong>rounded to 2 decimal places</strong>. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.</p>

<p>The&nbsp;result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
<strong>Output:</strong> 
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
<strong>Explanation:</strong> 
Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33
</pre>



Here's the query for the described problem, explained step by step:

---

### **Goal**
The task is to calculate the fraction of players who logged in on the day after their first login date, rounded to two decimal places.

---

### **Query**

```sql
SELECT 
    ROUND(SUM(player_logins) / COUNT(DISTINCT player_id), 2) AS fraction
FROM (
    SELECT 
        player_id, 
        DATEDIFF(event_date, MIN(event_date) OVER(PARTITION BY player_id)) = 1 AS player_logins
    FROM 
        activity
) AS logins;
```

---

### **Step-by-Step Explanation**

#### 1. **Inner Query**: 
   ```sql
   SELECT 
       player_id, 
       DATEDIFF(event_date, MIN(event_date) OVER(PARTITION BY player_id)) = 1 AS player_logins
   FROM 
       activity;
   ```
   - **Purpose**: Identify players who logged in exactly one day after their first login date.
   - **Logic**:
     - `MIN(event_date) OVER(PARTITION BY player_id)`:
       - Finds the first login date for each player (`player_id`).
     - `DATEDIFF(event_date, MIN(event_date) OVER(PARTITION BY player_id)) = 1`:
       - Calculates the difference in days between the login date (`event_date`) and the first login date (`MIN(event_date)`).
       - Returns `1` (true) if the difference is exactly one day, indicating the player logged in again on the day after their first login date.

   - **Result Example** (based on the input data):
     | player_id | player_logins |
     |-----------|---------------|
     | 1         | 1             |
     | 2         | 0             |
     | 3         | 0             |

---

#### 2. **Outer Query**: 
   ```sql
   SELECT 
       ROUND(SUM(player_logins) / COUNT(DISTINCT player_id), 2) AS fraction
   FROM 
       (...);
   ```
   - **Purpose**: Calculate the fraction of players who logged in again on the day after their first login.
   - **Key Components**:
     - `SUM(player_logins)`:
       - Counts the total number of players who logged in again on the day after their first login (`player_logins = 1`).
     - `COUNT(DISTINCT player_id)`:
       - Counts the total number of players.
     - `ROUND(..., 2)`:
       - Rounds the fraction to two decimal places.

   - **Calculation**:
     - Players who logged in the next day:
       - Player 1 logged in on both `2016-03-01` and `2016-03-02`.
       - Total = 1.
     - Total players = 3.
     - Fraction = `1 / 3 = 0.33`.

   - **Final Result**:
     | fraction |
     |----------|
     | 0.33     |

---

### **Output**
The query calculates the fraction of players who logged in again on the day after their first login, rounded to two decimal places.

| fraction |
|----------|
| 0.33     |

---


