# Referential Integrity
## Introduction
The code in this repository is the accompanying material for the article   [**Referential Integrity Beyond the Primary Key-Foreign Key Relationship**](https://medium.com/@nuhad.shaabani/referential-integrity-beyond-primary-key-foreign-key-relationship-65c403669741)
published on medium.

The underlying database is the university database used as a running example in the book **Database System Concepts**. 
The database is available at [https://www.db-book.com/db6/lab-dir/sample_tables-dir/index.html](https://www.db-book.com/db6/lab-dir/sample_tables-dir/index.html).
Changes made to the original scripts are commented on in the corresponding scripts.

The new scripts  added  are
* teaches_section_view.sql
* insert_teaches_section_trigger.sql
* delete_teaches_trigger.sql

## How to Install 
1. Download and unzip referential-integrity-main.zip.
2. CD into the directory with that file.
3. If you want to create a new schema, start SQL*Plus as a user who can create a new schema 
and run the script

`SQL> @create_user.sql user_name password default_tablespace temporary_tablespace`

where 
* user_name is the schema name (or simply the user) you want to create.
* pass_word is the password for the new schema.
* temporary tablespace is the default tablespace for the new schema.
* temporary_tablespace is the default temporary-tablespace for the new schema.

For example

`SQL> @create_user.sql test_user test_pass users temp `

4. Connect either to the schema newly created or to an existing one
and run the scripts
 
`SQL> @create_schema_objects.sql`

`SQL> @load_data.sql`

5. If you want to verify that the data is correctly loaded, run 
 
`SQL> @verify_data_load.sql`
