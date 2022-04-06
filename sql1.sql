insert into colors (name)
select * from
(select distinct rtrim(color1)
from animals
union
select distinct rtrim(color2)
from animals where color2 is not null);

create table colors(
    id integer primary key autoincrement
    ,name varchar(30));

select *
from colors;

create table animal_colors (
    animal_id int
    ,color_id int);

insert into animal_colors
select animals."index",
       colors.name
from animals
join colors on rtrim(animals.color1)=rtrim(colors.name);

insert into animal_colors
select animals."index",
       colors.name
from animals
join colors on rtrim(animals.color2)=rtrim(colors.name);

select animal_id, "color_id"
from animal_colors;

drop table outcomes;

create table outcomes(
    outcome_id integer primary key autoincrement,
    age_upon_outcome varchar(50),
    outcome_subtype varchar(50),
    outcome_type varchar(50),
    outcome_month int,
    outcome_year int,
    animal_id
);

insert into outcomes(age_upon_outcome, outcome_subtype, outcome_type, outcome_month, outcome_year, animal_id)
select distinct age_upon_outcome, outcome_subtype, outcome_type, outcome_month, outcome_year, animal_id
from animals;

create table animal_types(
    id integer primary key autoincrement,
    name varchar(30)
);

insert into animal_types (name)
select distinct (animal_type) from animals;

select *
from animal_types;

create table breed(
    id integer primary key autoincrement,
    name varchar(30)
);

insert into breed(name)
select distinct (breed)
from animals;

select *
from breed;

create table animals_fin (
    id integer primary key autoincrement,
    animal_id varchar(30),
    type_id int,
    name varchar(30),
    breed_id int,
    date_of_birth date
);

insert into animals_fin (animal_id, type_id, name, breed_id, date_of_birth)
select distinct animal_id, animal_types.id, animals.name, breed.id, date_of_birth
from animals
left join animal_types on animals.animal_type=animal_types.name
left join breed on animals.breed=breed.name
;

select *
from animals_fin;

select *
from outcomes
left join animals_fin on outcomes.animal_id=animals_fin.animal_id
;