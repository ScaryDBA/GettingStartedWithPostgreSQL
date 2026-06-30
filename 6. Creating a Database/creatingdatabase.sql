--Create a database using defaults
CREATE DATABASE my_first_db;


--Checking the owner of a database
SELECT
	pd.datname,
	pd.datdba,
	pg_catalog.pg_get_userbyid(pd.datdba) AS db_owner
FROM
	pg_catalog.pg_database AS pd
WHERE
	pd.datname = 'my_first_db';


--Creating another database with a specific owner

CREATE DATABASE my_second_db OWNER radiodev;


--Validating the owner of the newly created database
SELECT
	pd.datname,
	pd.datdba,
	pg_catalog.pg_get_userbyid(pd.datdba) AS db_owner
FROM
	pg_catalog.pg_database AS pd
WHERE
	pd.datname = 'my_second_db';


--Creating the ham_shack database
CREATE DATABASE ham_shack;



--Checking connection info
\conninfo


-- Querying database ownership again

SELECT
	pd.datname,
	pg_catalog.pg_get_userbyid(pd.datdba) AS db_owner
FROM
	pg_catalog.pg_database AS pd
WHERE
	datname = current_database();
