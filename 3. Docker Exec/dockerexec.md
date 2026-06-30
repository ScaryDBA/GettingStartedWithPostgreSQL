# Gaining Access to the Container OS

While we are running PostgreSQL within a container, certain operations we do will have to be done within the minimal Linux operating system that supports Postgres in its execution within the container. In this class, we'll be connecting to PostgreSQL using psql, the default command line utility for running SQL within Postgres. In other classes we may need to change PostgreSQL configuration files or perform other actions within the Linux OS. Therefore, we'll do a quick overview of how to connect to that OS within the container.

## Docker Exec

One of the commands within Docker is `exec`. This command is used at the command line to open a shell into the running container in order to perform actions directly within the container. In our case, we'll be using psql to run SQL queries. The command to start a shell within a container is simple:

```bash
docker exec -it StartingPostgreSQL "bash"
```

The flag -it let's Docker know that we're starting an interactive shell command. We have to supply the container to which we want to connect through the container name. Finally, we supply what we wish to execute, a bash shell.

Running this from the command line, you'll see your folder change from whatever it was to something like this:

```bash
root@6ae8a06273fe:/#
```

That's showing that I'm at the root of the container within bash. The numbered value is supplied by Docker and will doubtless be different on your container.

You can validate that you're not local by running some simple commands. For example:

```bash
ls
```

Will show you the folder and file listing within the container, which are doubtless different than your machine.

A more effective check would be to look for the docker environment values:

```bash
ls -l /.dockerenv
```

The output should be something similar to this:

```text
-rwxr-xr-x 1 root root 0 Jun 18 13:26 /.dockerenv
```

Obviously, the date will absolutely be different. One other way to validate that you're running in the PostgreSQL container (assuming you're not running PostgreSQL locally as a service) would be to look for the $POSTGRES_USER value:

```bash
echo $POSTGRES_USER
```

If that returns `postgres` and you've followed the scripts as written, then you're absolutely within a shell in your container.

To leave the shell, simply issue this command:

```bash
exit
```

That will drop you out of the shell within your container back to the command line. You can leave the shell open (or we'll reopen the shell at the start of the next lesson) for the next lesson, Connecting to PostgreSQL.

One note before we finish, while the standard PostgreSQL container does have a bash shell, some containers may not. You can simply run 'sh' as the shell to get access to a bare bones shell on most containers.
