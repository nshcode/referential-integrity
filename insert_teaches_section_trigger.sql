create or replace trigger insert_teaches_section_trg 
instead of insert on teaches_section_vw
for each row
declare
    is_section_exist int := 0;
begin
    begin 
        select 1 into is_section_exist
        from section s
        where s.course_id  = :NEW.course_id
            and s.sec_id   = :NEW.sec_id
            and s.semester = :NEW.semester
            and s.year     = :NEW.year;
        exception
            when NO_DATA_FOUND then
                is_section_exist := 0;
    end;
    if is_section_exist = 0 then
        insert into section(course_id
                            ,sec_id
                            ,semester 
                            ,year
                            ,building
                            ,room_number
                            ,time_slot_id)
                    values (:NEW.course_id
                            ,:NEW.sec_id
                            ,:NEW.semester 
                            ,:NEW.year
                            ,:NEW.building
                            ,:NEW.room_number 
                            ,:NEW.time_slot_id);
    end if;
    insert into teaches(ID
                        ,course_id
                        ,sec_id
                        ,semester
                        ,year)
                values (:NEW.ID
                        ,:NEW.course_id
                        ,:NEW.sec_id 
                        ,:NEW.semester
                        ,:NEW.year);
    exception 
        when others then
            declare 
                l_err_msg varchar(255) := sqlerrm;
            begin    
                dbms_output.put_line('A proplem occurs during ' || 
                            'inserting into section or teaches.');
                dbms_output.put_line(l_err_msg);
                raise;
            end;
end;
/
