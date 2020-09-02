CREATE OR REPLACE FUNCTION get_density(quart1 int, quart2 int, quart3 int)
RETURNS table (name text, population bigint, density int, niveau_densite text) 
AS $$

SELECT name, population, density,
    CASE 
        WHEN density > quart1 THEN 'Extreme'
        WHEN density > quart2 THEN 'Forte'
        WHEN density > quart3 THEN 'Intermediaire'
        ELSE 'Faible'
    END as niveau_densite
FROM country order by density DESC, population DESC;
$$
LANGUAGE SQL;

/*
select * from get_density(1000, 100, 50)
*/