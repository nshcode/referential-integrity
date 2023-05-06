
create or replace view teaches_section_vw as
select 
    t.id
    ,s.course_id
    ,s.sec_id
    ,s.semester
    ,s.year
    ,s.building
    ,s.room_number
    ,s.time_slot_id
from section s
join teaches t
    on s.course_id = t.course_id
    and s.sec_id   = t.sec_id
    and s.semester = t.semester
    and s.year     = t.year
;
