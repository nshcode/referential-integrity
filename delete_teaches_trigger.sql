create or replace trigger delete_teaches_trg 
for delete on teaches
compound trigger
    type t_teaches_type 
    is table of teaches%rowtype 
    index by pls_integer;
    t_cached_teaches t_teaches_type;
    
    -- Cache teaches into t_cached_teaches before deleting any row from it.
     before statement is 
        lr_teaches teaches%rowtype;
        begin
            for lr_teaches in (select * from teaches) 
            loop
                t_cached_teaches(t_cached_teaches.count + 1) := lr_teaches;      
            end loop;
        end before statement;
    
    -- Rollback the deletion if it is caused that at least one section has been left without a teaches record.
    after statement is
        cursor lc_section_without_teaches is 
                select course_id, sec_id, semester, year from section
                minus 
                select course_id, sec_id, semester, year from teaches;
        lr_section lc_section_without_teaches%rowtype;
        lt_to_reinsert_teaches t_teaches_type;
        lr_teaches  teaches%rowtype;
        l_is_to_reinsert boolean;
    begin
       for lr_section in lc_section_without_teaches
        loop
            for i in 1..t_cached_teaches.count 
            loop
                lr_teaches := t_cached_teaches(i);
                l_is_to_reinsert := lr_section.course_id = t_cached_teaches(i).course_id
                                    and lr_section.sec_id   = t_cached_teaches(i).sec_id
                                    and lr_section.semester = t_cached_teaches(i).semester
                                    and lr_section.year     = t_cached_teaches(i).year;
                if l_is_to_reinsert then
                    lt_to_reinsert_teaches(lt_to_reinsert_teaches.count + 1) := t_cached_teaches(i);
                end if;
            end loop;
        end loop;
        if lt_to_reinsert_teaches.count > 0 then 
            for i in 1..lt_to_reinsert_teaches.count
            loop
                execute immediate 'insert into ' 
                                ||'teaches(id, course_id, sec_id, semester, year) ' 
                                || 'values (:1, :2, :3, :4, :5)'
                using lt_to_reinsert_teaches(i).id
                    ,lt_to_reinsert_teaches(i).course_id
                    ,lt_to_reinsert_teaches(i).sec_id
                    ,lt_to_reinsert_teaches(i).semester
                    ,lt_to_reinsert_teaches(i).year;
            end loop;
            raise_application_error(-20100, 
            'Deletion rolled back because it violated the referential integrity '
                || 'between section and teaches.');
        end if;
    end after statement;
end;
/
