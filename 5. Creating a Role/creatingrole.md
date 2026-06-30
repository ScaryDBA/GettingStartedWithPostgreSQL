# Creating a Role

One of the more important aspects of PostgreSQL that is important to understand is that of ownership. The owners of objects, not only such as a schema inside a database, but the database itself, is very fundamental to both Postgres security and behaviors. With that in mind, instead of first creating a database to work on within PostgreSQL, we'll start by creating a role. With the role created, we can then log in to that role and validate that it works. With it working, we'll be ready to move on to the next lesson and create a database.

Older versions of PostgreSQL don't have roles, but instead have users. The `CREATE USER` command is still a part of Postgres, but it simply acts now as an alias to create a role.

## Running a script with psql

Instead of typing in psql or copying and pasting into it, this time, we'll let psql run a script for us. Externally, in your operating system, we're going to copy the file `creatingrole.sql` into the volume we created with the container. In Linux, you can use the Files gui, or issue a command similar to the following:

```bash
cp "5. Creating a Role/creatingrole.sql" /mnt/c/Users/grant/bu
```

If you're in Windows and not running through WSL, use File Explorer or a command similar to the following:

```powershell
Copy-Item "5. Creating a Role\creatingrole.sql" C:\Users\grant\bu
```

Obviously, you'll have to modify these commands for the paths on your own system. What this does is place the file into the local folder that is visible inside the container as a volume.

The container has to be running. You'll want to open a bash shell to the container if you've closed it (see Lesson 3). If you're connected to bash in the container, you'll see something similar to this:

```text
root@543bcc6b5270:/#
```

We can validate that the file exists by running this command within the bash shell:

```bash
ls /var/lib/postgresql/bu
```

Adjusting the path as appropriate to your system. The output will look something like this:

```text
root@bc83314d37ff:/# ls /var/lib/postgresql/bu
creatingrole.sql
```

Now that we know the script is availble, we can execute a script through psql like this:

```bash
psql -d postgres -h localhost -U postgres -f "/var/lib/postgresql/bu/creatingrole.sql"
```

That should run successfully to create a role called `radiodev` with a hard-coded password, `*securepassword*`. While we're still in bash, you could run a simple query to see if the role actually exists and if it has the permission to create a database.

The command we issued through the script is here:

```sql
CREATE ROLE radiodev WITH
    LOGIN
    CREATEDB
    PASSWORD '*securepassword*';
```

Breaking this down just a little, let's talk about what happens. The first part should be straight forward, `CREATE ROLE radiodev` means we're creating a role with the name 'radiodev'. The `WITH` command allows us to add some additional behaviors to the role. First up, we're creating this role as one that can connect to the cluster through the `LOGIN` process. Then, we're giving it an explicit permission, the ability to `CREATEDB`, or create databases. Finally, we're supplying a password for the role. In this short class, we won't need the password because we'll be doing the work through psql running as a local connection, therefore, a trusted one. There are of course additional options available for CREATE ROLE. Look those up in the PostgreSQL documentation.

## Validating the creation of the role

I'm going to leave bash in order to be operating within my OS. I'll then use the appropriate command to copy the file into the volume folder. I'll go back into bash and execute the query:

```bash
## leave bash
exit

## copy the file
cp "5. Creating a Role/creatingrolevalidation.sql" /mnt/c/Users/grant/bu

## go back into bash
docker exec -it StartingPostgreSQL "bash"

## run the query
psql -d postgres -h localhost -U postgres -f "/var/lib/postgresql/bu/creatingrolevalidation.sql"
```

The results should come back like this:

```text
 rolname  | rolcanlogin | rolcreaterole | rolcreatedb 
----------+-------------+---------------+-------------
 radiodev | t           | f             | t
 ```

Going forward in the book, we'll copy any or all files at the same time rather than going in and out of bash to do it. You can of course, use other mechanisms as well, again, rather than leave bash. In future clases, we'll introduce additional tools for querying PostgreSQL on top of psql that can make all these operations somewhat easier.

## Testing the role

We can now use the new role with our PostgreSQL. To see it in action, we can use the following script:

```bash
psql -d postgres -h localhost -U radiodev -c "\conninfo"
```

A couple of points here. In our initial use of psql, we typed in commands directly. Then, in the beginning of this lesson, we executed the scripts from within files. Finally, here, we're simply passing a command through the `-c` flag. Putting SQL, or, in this case a meta command, inside double quotes will provide the command to be executed. The output from my machine is here:

```text
      Connection Information
      Parameter       |   Value   
----------------------+-----------
 Database             | postgres
 Client User          | radiodev
 Host                 | localhost
 Host Address         | ::1
 Server Port          | 5432
 Options              | 
 Protocol Version     | 3.0
 Password Used        | false
 GSSAPI Authenticated | false
 Backend PID          | 441
 SSL Connection       | false
 Superuser            | off
 Hot Standby          | off
```

The most important thing I'll point out here is the fact that 'Superuser' is set to a value of 'off'. In short, this is a different role on the cluster, not the principal administrator, postgres. Let's move on to creating our first databases in PostgreSQL in Lesson 6.
