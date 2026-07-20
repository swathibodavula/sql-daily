-- 2026-07-20 — Consecutive Streaks
--
-- Filter to present rows first, then number them per employee
-- in date order. Within a run of consecutive days both the date and the row
-- number increase by 1, so (work_date - row_number) is constant across the run
-- and shifts the moment a day is missing. That constant is the island id.
--
-- The WHERE must live inside the CTE: filtering after numbering lets absent
-- days consume row numbers and the arithmetic breaks.

WITH present_days AS (
    SELECT
        employee_id,
        work_date,
        work_date - cast(ROW_NUMBER() OVER (
            PARTITION BY employee_id ORDER BY work_date
         ) as int)  AS grp
    FROM Attendance
    WHERE status = 'present'
)

SELECT employee_id, MIN(work_date) as start_Date, MAX(work_date) as end_date, count(*) as streak_length
from present_days
group by employee_id, grp
having count(*) >= 3
order by employee_id, start_Date;


