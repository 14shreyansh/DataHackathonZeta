create table temp.user_stats_sj5 as (
select
	s.account_holder_id::varchar(256) as custid,
	count(distinct transactionid) ::integer as frequency,
	abs(datediff('day', (date_trunc('month', current_date) - interval '1 day')::date,
                        max(createdat)::date))::integer as recency,
	sum(txn_amount) ::integer as monetary
from
	temp.v_vbo_account_holder_spends s
join vbo.vbo_ledger_master lm on
	lm.ledgerid = s.ledgerid
	and lm.ifi = s.ifi
where
	ah_type = 'REAL'
	and recordtype = 'DEBIT'
	and lm.ah_createdat <= (date_trunc('month', current_date) - interval '1 day')
	and s.createdat <= (date_trunc('month', current_date) - interval '1 day')
	and lm.ifi in (156699, 413476, 158326, 163924)
group by
	1)