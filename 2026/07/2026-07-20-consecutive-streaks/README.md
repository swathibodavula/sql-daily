# 2026-07-20 — Consecutive Streaks

**Technique:** gaps and islands
**Difficulty:** medium

## Problem

Table `Attendance`:

| Column | Type |
|--------|------|
| employee_id | INT |
| work_date | DATE |
| status | VARCHAR — `'present'` or `'absent'` |

Primary key: `(employee_id, work_date)`

Find every employee who was marked `present` on **3 or more consecutive calendar days**.
Return `employee_id`, the `start_date` and `end_date` of each qualifying streak, and the
streak length, ordered by `employee_id`, then `start_date`.

Dates in the table may have gaps — weekends and holidays are simply missing rows. A streak
only counts if the dates are truly consecutive calendar days.

## Sample input

| employee_id | work_date | status |
|---|---|---|
| 1 | 2026-07-01 | present |
| 1 | 2026-07-02 | present |
| 1 | 2026-07-03 | present |
| 1 | 2026-07-05 | present |
| 2 | 2026-07-01 | present |
| 2 | 2026-07-02 | absent |
| 2 | 2026-07-03 | present |
| 2 | 2026-07-04 | present |
| 2 | 2026-07-05 | present |
| 2 | 2026-07-06 | present |

## Expected output

| employee_id | start_date | end_date | streak_length |
|---|---|---|---|
| 1 | 2026-07-01 | 2026-07-03 | 3 |
| 2 | 2026-07-03 | 2026-07-06 | 4 |

## Notes

Employee 1's `07-05` is a one-day island — the `07-04` gap breaks the run.
Employee 2's `07-01` is likewise isolated by the absence on `07-02`.
