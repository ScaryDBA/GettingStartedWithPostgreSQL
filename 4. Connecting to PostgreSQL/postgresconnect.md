# Running psql

Before we continue on to actually executing psql, if you exited the bash shell in the container in the last lesson, or, you're starting this one from scratch, let's be sure we're connected to the shell in our container:

`docker exec -it StartingPostgreSQL "bash"`

## psql

psql is considered to be the official interface for PostgreSQL. It's a command line for interacting with and administering PostgreSQL clusters. You can issue SQL commands and you can take advantage of utilities built in to psql. In this lesson, we're going to explore the basic connection to Postgres using psql. Then, in following lessons we'll use psql to create objects within the cluster to act as the basis for our class.

I'm assuming you're following the lesson plan, so you'll be running this within a bash shell inside your container. However, you wouldn't run it any differently from the command line of your host OS. For our container as configured, here's how we would connect to it through psql:

`psql -d postgres -h localhost -U postgres`

When you run this inside a container, you won't be prompted for a password because you're in a trusted environment. Otherwise, when running psql, you'll need to supply the password used when creating the container (in the example, Some*Passw0rd). You're forced to provide a password in order to keep the password out of the history of commands in your CLI as a beneficial security measure. If you are running psql from an external command line, not within the bash shell as we're doing, there are a couple of ways to supply a password without typing it each time. One way is to create an environment variable on your machine, but that's less secure than simply entering the password. Another way is to create a secured file (chmod 0600) in your file system. We'll just stick to the password for our examples.

We're logging in to the default database, `postgres`, and using the user we created back in Lesson 2, `postgres`.

Your prompt should change to something like this:

`psql (18.4 (Debian 18.4-1.pgdg13+1))
Type "help" for help.

postgres=# `

We can validate that we're successfully connected to PostgreSQL several ways. First, we can use one of the meta commands (so designated by a backslash `\` before the command). All meta commands are stored in `*.sql` files since they can only be run through psql. To see the connection information of PostgreSQL, we can run the following:

`\conninfo`

This will return a bunch of information about your connection as illustrated here:

`      Connection Information
      Parameter       |   Value   
----------------------+-----------
 Database             | postgres
 Client User          | postgres
 Host                 | localhost
 Host Address         | ::1
 Server Port          | 5432
 Options              | 
 Protocol Version     | 3.0
 Password Used        | false
 GSSAPI Authenticated | false
 Backend PID          | 87
 SSL Connection       | false
 Superuser            | on
 Hot Standby          | off
(13 rows)`

Worth noting, if your CLI window has fewer than 13 lines available, by default it will page the results. You'll need to use `q` to move on to the next page. 

Since we're connected to psql, you can immediately run a query instead of a meta command. One thing to know up front, every connection to PostgreSQL is to a specific database and that database only. There is no concept of cross-database queries. Any query we issue is going to run against the database specified in the connection. In this case that will be the postgres database. We could use this query to understand where we're connected:

`SELECT version();`

At the time I'm writing this lesson plan, the output is:

`                                                     version                                                       
--------------------------------------------------------------------------------------------------------------------
 PostgreSQL 18.4 (Debian 18.4-1.pgdg13+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 14.2.0-19) 14.2.0, 64-bit`

A few things to note. First, in the query you'll see the end terminated with a semi-colon (;). In PostgreSQL, query statements must be terminated with a semi-colon. This is not like some data platforms where the statement terminator of a semi-colon is syntactic sugar. It's required for PostgreSQL. However, it's not required for the meta commands. Second, you get to see exactly how this container was created. Not simply that it's PostgreSQL. It's version 18.4. The next is not that it's Linux. It's Debian 14.2.0. You're supplied full information about this Postgres cluster. You'll also note the "-1.pgdg13+1" in the parenthesis. This is the version of the container and who compiled it. 

While we're here, let's try out a couple of more meta commands that are useful to know. First, and probably most important, you can get a full listing of all meta commands:

`\?`

Be aware, that will likely enter into paging.

We can also get a list of databases:

`\l`

This is unlikely to page on our example container because there should only be three databases; postgres (the one we're connected to), template0 and template1. We'll discuss the templates more in lesson 6.

With the basics of psql under our belts, let's start working within PostgreSQL in Lesson 5, Creating a Role.