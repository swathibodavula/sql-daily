-- NOTE: the predicate belongs in is ON, not WHERE.
-- ON is evaluated while the join is built, so it only limits which rows
-- count as a match. Research has no employees, gets NULL-extended by the
-- LEFT JOIN, and is preserved.
-- In WHERE it would be evaluated after the join, where NULL <= 2 yields
-- NULL (not TRUE), Research would be discarded, and the LEFT JOIN would
-- silently collapse to an INNER JOIN.



with temp as (
    select employee_id, emp_name, department_id, salary,
        dense_rank() over (partition by department_id order by salary desc) as rnk
        from Employees
)

select d.dept_name, t.emp_name, t.salary, t.rnk
from Departments d
left join temp t on d.department_id = t.department_id
and t.rnk <=2
order by d.dept_name, t.rnk, t.emp_name;



