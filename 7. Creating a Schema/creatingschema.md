# Creating a Schema

Siimilar to other data platforms, PostgreSQL uses the concept of a schema as a mechanism for organizing a database. A schema can also be used for security, for data isolation, and mostly, as a means of logically storing related objects. By default, each database, including the postgres database, comes with a schema by default, `public`. While many databases simply store all tables in the `public` schema, it's a very good habit to instead intentionally store your tables, views, etc., within defined schema. This partly for security, but mainly as a good management practice.

Let's start by connecting directly to psql and see what schema are already in the database, if any:

```bash
psql -d ham_shack -h localhost -U radiodev
```

Connected to psql, we can take a look at the schema in the `ham_shack` database using a meta command:

```sql
\dn
```

The results are shown here:

```text
      List of schemas
  Name  |       Owner       
--------+-------------------
 public | pg_database_owner
```

As I said, only the default, `public`, schema.

The meta commands can actually show you more than just a simple list. We can make the call this way:

```sql
\dn+
```

Which gives us additional information, mainly the priveleges on the schema in question:

```text
                                       List of schemas
  Name  |       Owner       |           Access privileges            |      Description       
--------+-------------------+----------------------------------------+------------------------
 public | pg_database_owner | pg_database_owner=UC/pg_database_owner+| standard public schema
        |                   | =U/pg_database_owner                   | 
```

## First Schema and the `search_path`

Let's just get started and create a schema called `gear` from within psql:

```sql
CREATE SCHEMA gear;
```

And if we use the `\dn` meta command from above, we can now see our new schema:

```text
  Name  |       Owner       
--------+-------------------
 gear   | radiodev
 public | pg_database_owner
```

However, let's start talking about the `search_path`. First, let's see what's currently in it:

```sql
SHOW search_path;
```

On a completely new database such as this, this command returns the following:

```text
   search_path   
-----------------
 "$user", public
```

First up, the `SHOW` command is used to return runtime configuration parameters. This could be settings such as timezone or max_connections, but in our case, we're going for the `search_path`. The `search_path` is where the role you're operating within looks through the database for objects. If you don't have a schema in the search path, you won't be able to see objects within that schema in order to query them. The order of the `search_path` matters as well. Postgres will look within the first schema in the search path for an object. If it finds it there, it won't continue to look through the other schema. That assumes of course, you haven't used the schema when referencing the object. If you use the schema in the object name, such as `gear.radio` for a table name, and you have access to that schema, then the search_path doesn't matter. However, even if you have appropriate access, if you simply referenced the table `radio`, with the search_path we currently have, you wouldn't find that table.

The `"$user"` is a token that resolves to the currently connected role. This is where, you could create a schema called `radiodev` and it would automatically be referenced by our login.

Happily, modifying the search_path is easy:

```sql
SET search_path TO "$user", gear, public;
```

If you don't include `"$user"` or `public` when you change the `search_path`, they will be removed, so be careful. However, using the `SET` command will only change the `search_path` for the duration of the current connection.

In order to change the `search_path` permanently, you have to either `ALTER` the role itself, or the database. Here is an example that will add the `gear` schema to the role:

```sql
ALTER ROLE radiodev SET search_path TO "$user", gear, public;
```

However, that will only take affect on new connections for this role. You would either have to use the `SET` command along with the `ALTER ROLE`, or, disconnect and reconnect to the database. Before we test the new and improved 'search_path', let's add one more schema:

```sql
CREATE SCHEMA people;
ALTER ROLE radiodev SET search_path TO "$user", gear, people, public;
exit
```

If you now connect again to psql and run the SHOW command, you'll see the following:

```text
          search_path          
-------------------------------
 "$user", gear, people, public
```

With that in hand, we can begin the process of creating tables in Lesson 8 Creating Tables.
