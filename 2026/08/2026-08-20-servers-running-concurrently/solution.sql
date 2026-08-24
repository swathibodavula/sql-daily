-- Write a query that returns, for every server:

-- The maximum number of jobs running concurrently.
-- The earliest timestamp when that maximum was reached.

-- Treat end_time as exclusive. Therefore, if one job ends exactly when another starts, they are not running concurrently.

with events as (
    select server_id, start_time as event_time, 1 as change 
    from job_runs
    where start_time is not null

    union all

    select server_id, end_time as event_time, -1 as change
    from job_runs
    where end_time is not null 
),
running as (
    select server_id, event_time, sum(change) over (partition by server_id order by event_time, change rows unbounded preceding) as concurrent_jobs
    from events
),
max_running as (
    select server_id, max(concurrent_jobs) as max_jobs
    from running
    group by server_id
)
select r.server_id, m.max_jobs, 
min(r.event_time) as earliest_timestamp
from running r
join max_running m on r.server_id = m.server_id 
and r.concurrent_jobs = m.max_jobs
group by r.server_id, m.max_jobs
order by r.server_id;