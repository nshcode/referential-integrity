set feedback 1
set serveroutput on

prompt specify username as parameter 1:
define user = &1
prompt
prompt specify password as parameter 2:
define pw = &2
prompt
prompt specify default tablespace as parameter 3:
define default_ts = &3
prompt
prompt specify temporary tablespace as parameter 4:
define temp_ts = &4
prompt

whenever sqlerror exit sql.sqlcode;
exec  dbms_output.put_line('Checking if the user exists in the database...');
declare
    v_user_exists int := 0;
begin
    select count(username)
    into v_user_exists
    from all_users
    where username = upper('&&user');
    if v_user_exists = 1 then
        raise_application_error(-20100, 'The user ' || upper('&&user') || ' already exists.');
    end if;
end;
/

create user &&user identified by &&pw;
alter user  &&user default tablespace &&default_ts quota unlimited on &&default_ts;
alter user  &&user temporary tablespace &&temp_ts;

grant create session to &&user;
grant alter session  to &&user;
grant create table   to &&user;
grant create view    to &&user;
grant create trigger to &&user;


