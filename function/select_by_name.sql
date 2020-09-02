create or replace function select_by_name (country_name text) 
returns country as 
$$ SELECT * FROM country WHERE country.name = country_name; $$ 
LANGUAGE sql;

/* select * from select_by_name('China');
 */