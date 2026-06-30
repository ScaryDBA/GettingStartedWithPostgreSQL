--Meta command for a list of schema

\dn


--Meta command for schema security settings

\dn+


--Create a schema

CREATE SCHEMA gear;


--check the search_path

SHOW search_path;


--Use the SET command to change the search_path

SET search_path TO "$user", gear, public;


--Use the ALTER ROLE command to change the search_path for a role

ALTER ROLE radiodev SET search_path TO "$user", gear, public;


--Add one more schema and exit

CREATE SCHEMA people;
ALTER ROLE radiodev SET search_path TO "$user", gear, people, public;
\q

