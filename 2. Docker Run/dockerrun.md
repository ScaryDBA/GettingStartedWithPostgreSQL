# Creating a Container Using Docker Run

Once an image has been created locally, you can now use that image to create containers. As was stated in the last lesson, you can simply use `docker run` to both pull the image and create the container. Either way, we'll need to break down the core requirements for creating a PostgreSQL container using `docker run`. This is the full command that we'll be using:

`docker run -d --name StartingPostgreSQL \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD=$omePassw0rd \
    -v /home/grant/bu:/var/lib/postgresql/bu \
    -e POSTGRES_USER=postgres \
    postgres:latest`

Before we run the script though, let's talk about a few important pieces of information here. First, I'm going to recommend you create at least one volume on your container, the `-v` flag. A volume is way to map an external directory on your machine to a location within the container. Then, you can place files into that folder and they'll be readable within the container and outside in your operating system. If you wanted to have `*.sql` files or PostgreSQL dump files available within the container, this is the easy way to do it.

You can get very sophisticated with volumes if you choose, but for our purposes, simply the ability to easily move scripts in is enough.

You don't have to supply a name to the container, but it does make managing the container easier. That's the `--name` flag.

Next, you have to map between an external and internal port. Since I'm only running the one container, I'm going to go ahead and map it to the default PostgreSQL port, 5432, `-p 5432:5432`.

For a container, a simple role is all that's needed to connect to the cluster running inside the container. I have to use the environment variable flag, `-e`, to map to a particular key two times, `POSTGRES_PASSWORD` and `POSTGRES_USER`. The name supplied to `POSTGRES_USER` is going to be the default super user, system administrator if you will, of the PostgreSQL cluster running in the container. In the example, I use the default value for the super user in most Postgres installs, postgres. 

Finally, I supply the name of the Docker image, `postgres:latest.`

