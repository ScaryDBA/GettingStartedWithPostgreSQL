-- Validate that role created exists

SELECT
	pr.rolname,
	pr.rolcanlogin,
	pr.rolcreaterole,
	pr.rolcreatedb
FROM
	pg_roles AS pr
WHERE pr.rolname = 'radiodev';

