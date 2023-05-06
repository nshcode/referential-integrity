set serveroutput on;

declare 
    type t_expected_row_count_type is
        table of int not null
        index by varchar2(50);
        
    t_expected_row_count t_expected_row_count_type; 
    v_current_count  int;
    v_expected_count int;
    v_current_tab    varchar2(50);
begin
   t_expected_row_count('CLASSROOM')  := 5;
   t_expected_row_count('DEPARTMENT') := 7;
   t_expected_row_count('COURSE')     := 13;
   t_expected_row_count('INSTRUCTOR') := 12;
   t_expected_row_count('SECTION')    := 15;
   t_expected_row_count('TEACHES')    := 15;
   t_expected_row_count('STUDENT')    := 13;
   t_expected_row_count('TAKES')      := 22;
   t_expected_row_count('ADVISOR')    := 9;
   t_expected_row_count('time_slot')  := 20;
   t_expected_row_count('PREREQ')     := 7;
    
    v_current_tab :=t_expected_row_count.first;
    while v_current_tab is not null
    loop
        v_expected_count := t_expected_row_count(v_current_tab);
        execute immediate 'select count(*) from ' || v_current_tab 
        into v_current_count;
        if v_current_count = v_expected_count then
            dbms_output.put_line(v_current_tab || ': OK');
        else 
            dbms_output.put_line(
                v_current_tab || ': NOT OK (current=' || v_current_count || ', but expected=' || v_expected_count || ')');
        end if;
        v_current_tab :=t_expected_row_count.next(v_current_tab);
    end loop;
end;
/

