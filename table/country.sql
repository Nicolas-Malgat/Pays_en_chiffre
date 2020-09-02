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