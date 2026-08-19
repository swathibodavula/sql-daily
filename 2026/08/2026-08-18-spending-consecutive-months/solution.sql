-- Q: Find users whose spending increased for 3+ consecutive months.
-- Output: user_id | start_month | end_month | num_months
--
-- Builds maximal increasing runs (gaps-and-islands) rather than fixed 3-month
-- windows, so C reports one Feb->May run of 4 instead of two overlapping rows.

with cte_user_monthly_totals as (
    select
        user_id,
        date_trunc('month', transaction_date) as month,
        sum(amount) as total_amount
    from transactions
    group by 1,2
),

cte_mom as (
    select
        user_id,
        month,
        total_amount,
        lag(month) over w as prev_month,
        lag(total_amount) over w as prev_amount
    from cte_user_monthly_totals
    window w as (partition by user_id order by month)
),

-- A run continues only if the previous row is the adjacent calendar month
-- AND spend strictly rose. Anything else starts a new run.
cte_streak_breaks as (
    select
        *,
        case
            when prev_month = month - interval 1 month and total_amount > prev_amount then 0
            else 1
        end as is_streak_start
    from cte_mom
),

cte_streaks as (
    select
        *,
        sum(is_streak_start) over (
            partition by user_id
            order by month
            rows between unbounded preceding and current row
        ) as streak_id
    from cte_streak_breaks
)

select
    user_id,
    min(month)::date as start_month,
    max(month)::date as end_month,
    count(*)         as num_months
from cte_streaks
group by user_id, streak_id
having count(*) >= 3
order by user_id, start_month;