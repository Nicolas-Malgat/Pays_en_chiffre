DROP TABLE IF EXISTS country CASCADE;

CREATE TABLE country (
	country_name varchar(50) NOT NULL,
	population int8 NOT NULL,
	yearly_change float4 NOT NULL,
	net_change int8 NOT NULL,
	density int4 NOT NULL,
	land_area int8 NOT NULL,
	migrant float4 NULL,
	fertility_rate float4 NULL,
	medium_age int4 NULL,
	urban_population int4 NULL,
	world_share float4 NOT NULL,
	insertion_date date NULL
);

-- Table Triggers

CREATE OR REPLACE FUNCTION country_insertion_date()
RETURNS TRIGGER as
$$ begin
new.insertion_date = now();
return new;
end; $$
LANGUAGE PLPGSQL;


DROP TRIGGER IF EXISTS trigger_name ON country;

CREATE TRIGGER country_insertion_date BEFORE INSERT ON country
    FOR EACH ROW EXECUTE procedure country_insertion_date();

-- FUNCTIONS

create or replace function select_by_name (country_name text) 
returns country as 
$$ SELECT * FROM country WHERE country_name = country_name; $$ 
LANGUAGE sql;

CREATE OR REPLACE FUNCTION group_by_density(quart1 int, quart2 int, quart3 int)
RETURNS table (country_name text, population bigint, density int, niveau_densite text) 
AS $$

SELECT country_name, population, density,
    CASE 
        WHEN density > quart1 THEN 'Extreme'
        WHEN density > quart2 THEN 'Forte'
        WHEN density > quart3 THEN 'Intermediaire'
        ELSE 'Faible'
    END as niveau_densite
FROM country order by density DESC, population DESC;
$$
LANGUAGE SQL;

-- PROCEDURES

create or replace procedure insert_country(IN name text)
language plpgsql
as $$
declare
	population bigint;
	yearly_change float4;
	net_change bigint;
	land_area int;
	density int;
	migrant int;
	fertility_rate float4;
	medium_age int;
	urban_population int;
	world_share float4;
begin
	population := RANDOM()*1000000;
	yearly_change := RANDOM()*0.1;
	land_area := RANDOM()*100000;
	net_change := population * yearly_change;
	density := population / land_area;

	migrant := RANDOM()*100000;
	fertility_rate := RANDOM()*10;
	medium_age := RANDOM()*100;
	urban_population := RANDOM()*100;
	world_share := RANDOM()*10;

insert into public.country values (name,population,yearly_change,net_change,density,land_area,migrant,fertility_rate,medium_age,urban_population,world_share,NULL);

end; $$