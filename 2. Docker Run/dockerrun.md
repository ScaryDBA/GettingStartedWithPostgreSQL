# Creating a Container Using Docker Run

Once an image has been created locally, you can now use that image to create containers. As was stated in the last lesson, you can simply use `docker run` to both pull the image and create the container. Either way, we'll need to break down the core requirements for creating a PostgreSQL container using `docker run`. This is the full command that we'll be using:

`docker run -d --name StartingPostgreSQL \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD=Some*Passw0rd \
    -v /home/grant/bu:/var/lib/postgresql/bu \
    -e POSTGRES_USER=postgres \
    postgres:latest`

## Volume

Before we run the script though, let's talk about a few important pieces of information here. First, I'm going to recommend you create at least one volume on your container, the `-v` flag. A volume is way to map an external directory on your machine to a location within the container. Then, you can place files into that folder and they'll be readable within the container and outside in your operating system. If you wanted to have `*.sql` files or PostgreSQL dump files available within the container, this is the easy way to do it.

Because of this, you will need to ensure that you have that folder already created on your local machine. The example script above is for a Linux machine. You'd need a different path for Windows (unless you're running everything through WSL on Windows).

You can get very sophisticated with volumes if you choose, but for our purposes, simply the ability to easily move scripts in to the container is enough.

## Name

You don't have to supply a name to the container, but it does make managing the container easier. That's the `--name` flag.

## Port Mapping

Next, you have to map between an external and internal port. Since I'm only running the one container, I'm going to go ahead and map it to the default PostgreSQL port, 5432, `-p 5432:5432`. If you want to run more than one container hosting PostgreSQL, you will need to provide a different external port value, the first number. For example, if you already have PostgreSQL running within a container or locally, you might substitute `-p 5433:5432` in order to map to a different port. You'll then need to provide that non-default port value to any connection to that PostgreSQL cluster.

## Environment Variable Flags

For a container, a simple role is all that's needed to connect to the cluster running inside the container. I have to use the environment variable flag, `-e`, to map to a particular key two times, `POSTGRES_PASSWORD` and `POSTGRES_USER`. The name supplied to `POSTGRES_USER` is going to be the default super user, system administrator if you will, of the PostgreSQL cluster running in the container. In the example, I use the default value for the super user in most Postgres installs, postgres. 

## Image

Finally, I supply the name of the Docker image, `postgres:latest.`

## Executing the Script

When you execute this command, you receive back an identifier for the container you created. You can use that identifier, or, you can use the name of the container you created. It's easier, and more clear, to use the name. You can validate that the container was successfully created above by running this command:

`docker ps -f 'name=StartingPostgreSQL'`

This should result in something similar to the following:

```text
CONTAINER ID   IMAGE             COMMAND                  CREATED         STATUS         PORTS                                         NAMES
6ae8a06273fe   postgres:latest   "docker-entrypoint.s…"   6 seconds ago   Up 5 seconds   0.0.0.0:5432->5432/tcp, [::]:5432->5432/tcp   StartingPostgreSQL
```

As you can see from the output, you get the ID for the container itself, as well as the name, the image used in creation, when it was created and the current status along with any ports.

That's it. You now have a functional PostgreSQL cluster running within a container.

## Stopping and Starting the Container

You can stop the container if you choose by issuing the following command:

`docker stop StartingPostgreSQL`

If you then subsequently wish to restart the container you can do the following:

`docker start StartingPostgreSQL`

Please leave the container in a running state to start the next lesson, Docker Exec.
