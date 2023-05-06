drop table instructor cascade constraints;
drop table student cascade constraints;
drop table department cascade constraints;
drop table classroom cascade constraints;
drop table section cascade constraints;
drop table teaches cascade constraints;
drop table course cascade constraints;
drop table takes cascade constraints;
drop table advisor cascade constraints;
drop table time_slot cascade constraints;
drop table prereq cascade constraints;

drop trigger insert_teaches_section_trg;
drop trigger delete_teaches_trg;
drop view teaches_section_vw;
