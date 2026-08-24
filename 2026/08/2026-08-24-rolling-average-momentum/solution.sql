-- Write your MySQL query statement below
-- For each day, compute the trailing 7-day moving average of revenue: the current day plus the six days before it. Round to 2 decimals. Return every day with its revenue and ma7.
--Return only the momentum days: days where a day's revenue was strictly greater than its own trailing 7-day average. Return sale_date, revenue, ma7, and percent_above — the percentage the day ran above its average — ordered by sale_date.

with rolling_avg as (
    select
        sale_date,
        revenue,
        round(avg(revenue) over(
            order by sale_date rows between 6 preceding and current row
        ), 2) as ma7
    from daily_sales
)
select sale_date, revenue, ma7, round((revenue - ma7) / ma7 * 100, 2) as percent_above
from rolling_avg
where revenue > ma7
order by sale_date;