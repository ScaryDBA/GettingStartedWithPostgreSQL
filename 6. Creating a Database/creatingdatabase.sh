## Create a database as postgres

psql -d postgres -h localhost -U postgres -c "CREATE DATABASE my_first_db;"


## Validating the database owner

psql -d postgres -h localhost -U postgres -c "SELECT
	pd.datname,
	pd.datdba,
	pg_catalog.pg_get_userbyid(pd.datdba) AS db_owner
FROM
	pg_catalog.pg_database AS pd
WHERE
	pd.datname = 'my_first_db';"

## Change database owner at creation

psql -d postgres -h localhost -U postgres -c "CREATE DATABASE my_second_db OWNER radiodev;"


## Validating the database owner
psql -d postgres -h localhost -U postgres -c "SELECT
	pd.datname,
	pd.datdba,
	pg_catalog.pg_get_userbyid(pd.datdba) AS db_owner
FROM
	pg_catalog.pg_database AS pd
WHERE
	pd.datname = 'my_second_db';"


## Creating ham_shack database

psql -d postgres -h localhost -U radiodev -c"CREATE DATABASE ham_shack;"


## Connecting psql to the ham_shack database

psql -d ham_shack -h localhost -U radiodev
