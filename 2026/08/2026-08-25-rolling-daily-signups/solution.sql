-- This SQL query calculates the rolling 7-day average of new user signups. It retrieves the signup date and the number of new users for each date, and then computes the average number of new users over the current day and the previous six days.


select 
    signup_date,
    new_users,
    round(avg(new_users) over(
        order by signup_date
        range between interval '6' day preceding and current row 
    ), 2) as rolling_7_day_avg
from signups;
