# Creating a Database

Now that we have a role with the permission to create databases, we could immediately create a database as that role. However, first, I want to show some other possibilities around creating a database.

## Superuser

If we were to issue a `CREATE DATABASE` command like this, that database would be owned by `postgres`, the superuser:

```bash
psql -d postgres -h localhost -U postgres -c "CREATE DATABASE my_first_db;"
```

Not only would this create a database that is owned by `postgres`, but since we gave it no other options, it's using just the defaults. Postgres has two template databases, template0 and template1. Template0 is for the system and should be left completely alone. Template1 is the default template for creating databases. Since this is a brand new cluster which has no other databases or templates created, this is perfectly OK for our purposes. You can create custom templates or even use other databases as a template when creating a new database. Those options go beyond our simple lessons here.

We don't want to use the superuser, postgres, to create databases for a number of reasons. First, and most importantly, it violates the least-privilege principal. Since the superuser bypasses a lot of security constraints, we're potentially exposing things in the system. Ownership and permissions in PostgreSQL cascade from the role that created the object. Even a database in Postgres is an object and you want a clear, easily audited, ownership chain. That's why it's best to start with defining ownership through roles other than the superuser.

We can look at the owner of a database using a simple query:

```bash
psql -d postgres -h localhost -U postgres -c "SELECT
	pd.datname,
	pd.datdba,
	pg_catalog.pg_get_userbyid(pd.datdba) AS db_owner
FROM
	pg_catalog.pg_database AS pd
WHERE
	pd.datname = 'my_first_db';"
```

We don't have to use the login to create the database. It's perfectly possible to assign ownership on creation:

```bash
psql -d postgres -h localhost -U postgres -c "CREATE DATABASE my_second_db OWNER radiodev;"
```

We then see the following results:

```text
   datname   | datdba | db_owner 
-------------+--------+----------
 my_first_db |     10 | postgres
 ```

Altering the script as follows:

```bash
psql -d postgres -h localhost -U postgres -c "SELECT
	pd.datname,
	pd.datdba,
	pg_catalog.pg_get_userbyid(pd.datdba) AS db_owner
FROM
	pg_catalog.pg_database AS pd
WHERE
	pd.datname = 'my_second_db';"
```

We get the following results:

```text
   datname    | datdba | db_owner 
--------------+--------+----------
 my_second_db |  16388 | radiodev
```

## Using radiodev

For the rest of the class, we'll be using a database called 'hamshack.' Since we're going to let the database owner also own the other objects we create within `hamshack` we need to go ahead and create the database. Other than the owner, there aren't any other database options we need to worry about, so we can just let the defaults handle things for us:

```bash
psql -d postgres -h localhost -U radiodev -c"CREATE DATABASE ham_shack;"
```

With the database created, let's connect to it through interactive psql instead of issuing commands all the time:

```bash
psql -d ham_shack -h localhost -U radiodev
```

The resulting connection will look different than what we've seen in other lessons:

```text
ham_shack=> 
```

That's because we're connected to a database other than `postgres`. Let's issue a few commands and queries to satisfy ourselves that we are indeed in a new database.

First, we could run the tried and tested meta command:

```sql
\conninfo
```

That gives us the following:

```text
      Connection Information
      Parameter       |   Value   
----------------------+-----------
 Database             | ham_shack
 Client User          | radiodev
 Host                 | localhost
 Host Address         | ::1
 Server Port          | 5432
 Options              | 
 Protocol Version     | 3.0
 Password Used        | false
 GSSAPI Authenticated | false
 Backend PID          | 937
 SSL Connection       | false
 Superuser            | off
 Hot Standby          | off
```

Another way would be to query using a built-in function:

```sql
SELECT
	pd.datname,
	pg_catalog.pg_get_userbyid(pd.datdba) AS db_owner
FROM
	pg_catalog.pg_database AS pd
WHERE
	datname = current_database();
```

You can simply copy and paste this command into psql. Since nothing is executed until the statement terminator is reached, the semi-colon (;), you can easily have multi-line commands. The function in use is `current_database()` which returns the database we're connected to. The results are here:

```text
  datname  | db_owner 
-----------+----------
 ham_shack | radiodev
```

As you can see, we're in a new database, owned by the role we just created. Let's exit psql for the moment:

```sql
exit
```

We'll still be connected to the container through bash. With our role and database in place, it's time to start to work within the database. We'll start on Lesson 7. Creating a Schema.
