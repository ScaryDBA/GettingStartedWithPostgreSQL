-- Validating the connection to a PostgreSQL cluster
-- NOTE: meta commands are included with *.sql 

\conninfo

-- Querying the version information
SELECT version();

-- Getting a list of databases
\l

--Disconnecting from psql
\q