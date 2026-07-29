-- TYPE YOUR SQL QUERY BELOW


-- PART 1: Create a SQL query that maps out the daily average users before and after the feature change

select
  period,
  round(avg(daily_users), 2) as avg_daily_active_users
from (
  select
    date(login_timestamp, 'unixepoch') as login_date,
    case
      when date(login_timestamp, 'unixepoch') < '2018-06-02' then 'before'
      else 'after'
    end as period,
    count(distinct user_id) as daily_users
  from login_history
  group by login_date
)
group by period;

-- Supporting query: the full daily DAU time series (used to plot the graph
-- of daily active users before/after the release date)
--
-- select
--   date(login_timestamp, 'unixepoch') as login_date,
--   case
--     when date(login_timestamp, 'unixepoch') < '2018-06-02' then 'before'
--     else 'after'
--   end as period,
--   count(distinct user_id) as daily_active_users
-- from login_history
-- group by login_date
-- order by login_date;


-- PART 2: Create a SQL query that indicates the number of status changes by card

select
  c.id as card_id,
  c.name as card_name,
  count(h.id) as status_change_count
from card c
left join card_change_history h on h.cardID = c.id
group by c.id, c.name
order by status_change_count desc;-- TYPE YOUR SQL QUERY BELOW










