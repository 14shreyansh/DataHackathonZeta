create table temp.user_rfm_final as
    (
        select s.custid,
               s.recency,
               s.frequency,
               s.monetary,
               s.recencycluster,
               s.frequencycluster,
               s.monetarycluster,
               s.recencyclustertag,
               s.frequencyclustertag,
               s.monetaryclustertag,
               s.flag                             as customer_segment,
               lm.mobile_number,
               ah.firstname || ' ' || ah.lastname as ah_name
        from temp.hacksjfinal1 s
                 join vbo.vbo_ledger_master lm on s.custid = lm.account_holder_id
                 join account.account_holder ah on ah.id = s.custid
        group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
    );