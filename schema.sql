/* Database schema to keep the structure of entire database. */

create table animals ( 
    id int serial primary key, 
    name text, 
    date_of_birth date, 
    escape_attempts int, 
    neutered boolean, 
    weight_kg decimal
);
alter table animals add column species text;
