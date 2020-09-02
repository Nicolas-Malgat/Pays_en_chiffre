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
