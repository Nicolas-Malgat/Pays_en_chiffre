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

/*
CALL insert_country('patate');

select * from country where "name" = 'patate'
*/