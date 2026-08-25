-- This SQL query is designed to identify user sessions based on page view events. A session is defined as a series of events from the same user that occur within a 30-minute window. If there is a gap of more than 30 minutes between events, a new session is started.


with flagged as (
    select
        user_id,
        event_time,
        case 
            when event_time - lag(event_time) over (partition by user_id order by event_time) > interval 30 minute
        or  lag(event_time) over (partition by user_id order by event_time) 
            is null
            then 1 else 0
        end as is_new_session
        from page_views 
),
sessioned as (
    select 
        user_id,
        event_time, sum(is_new_session) over(
            partition by user_id order by event_time rows unbounded preceding
        ) as session_id
    from flagged
)
select user_id,
    session_id,
    min(event_time) as session_start,
    max(event_time) as session_end,
    count(*) as num_events,
    date_diff('minute', min(event_time), max(event_time)) as duration_min
from sessioned
group by user_id, session_id,
order by user_id, session_id;