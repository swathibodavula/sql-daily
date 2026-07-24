# 2026-07-23 — Top-N Per Group

**Technique:** ranking window functions
**Difficulty:** medium

## Problem

Table `Departments`:

| Column | Type |
|--------|------|
| department_id | INT |
| dept_name | VARCHAR |

Primary key: `department_id`

Table `Employees`:

| Column | Type |
|--------|------|
| employee_id | INT |
| emp_name | VARCHAR |
| department_id | INT — FK to `Departments` |
| salary | DECIMAL(10,2) |

Primary key: `employee_id`

For each department, return the employees earning one of the **top 2 distinct salary values**
in that department. Return `dept_name`, `emp_name`, `salary`, and the salary's rank within
the department, ordered by `dept_name`, then rank, then `emp_name`.

Ties share a rank and every tied employee appears. If three people share a department's
highest salary, all three come back at rank 1 — and rank 2 is then the next *distinct* salary
below it, not the fourth-highest person.

Every department must appear in the output, including one with no employees at all. That row
shows the department name with `NULL` for the employee columns.

## Sample input

`Departments`:

| department_id | dept_name |
|---|---|
| 1 | Engineering |
| 2 | Sales |
| 3 | Research |

`Employees`:

| employee_id | emp_name | department_id | salary |
|---|---|---|---|
| 1 | Ana | 1 | 9000.00 |
| 2 | Ben | 1 | 9000.00 |
| 3 | Cara | 1 | 8000.00 |
| 4 | Dan | 1 | 7000.00 |
| 5 | Eve | 2 | 5000.00 |
| 6 | Fay | 2 | 6000.00 |
| 7 | Gus | 2 | 6000.00 |
| 8 | Hal | 2 | 6000.00 |
| 9 | Ivy | 2 | 4000.00 |

## Expected output

| dept_name | emp_name | salary | rnk |
|---|---|---|---|
| Engineering | Ana | 9000.00 | 1 |
| Engineering | Ben | 9000.00 | 1 |
| Engineering | Cara | 8000.00 | 2 |
| Research | NULL | NULL | NULL |
| Sales | Fay | 6000.00 | 1 |
| Sales | Gus | 6000.00 | 1 |
| Sales | Hal | 6000.00 | 1 |
| Sales | Eve | 5000.00 | 2 |

## Notes

Each department exercises a different edge case. Engineering has a 2-way tie at the top, and
Dan at 7000 is the third distinct salary — excluded. Sales has a 3-way tie at the top, so
rank 2 must be Eve at 5000: ties don't consume rank slots. Research has no employees and must
survive as a single `NULL`-extended row.

`DENSE_RANK` is the right function here. `ROW_NUMBER` would number tied rows 1, 2, 3 and let a
third-place earner slip in; `RANK` skips numbers after a tie, so Sales' 3-way tie would push
the next distinct salary to rank 4 and rank 2 would come back empty.

The trap is the rank predicate. It belongs in the join's `ON` clause, not `WHERE`. `ON` is
evaluated while the join is built, so it only limits which rows count as a match — Research
finds nothing, gets `NULL`-extended by the `LEFT JOIN`, and is preserved. In `WHERE` it runs
after the join is complete, where `NULL <= 2` yields `NULL` rather than `TRUE`, Research is
discarded, and the `LEFT JOIN` silently collapses into an `INNER JOIN`.