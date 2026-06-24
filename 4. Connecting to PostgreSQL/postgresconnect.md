# Running psql

Before we continue on to actually executing psql, if you exited the bash shell in the container in the last lesson, or, you're starting this one from scratch, let's be sure we're connected to the shell in our container:

`docker exec -it StartingPostgreSQL "bash"`

## psql

Within PostgreSQL, psql is considered to be the official interface for PostgreSQL. It's a command line for interacting with and administering PostgreSQL clusters. You can issue SQL commands and you can take advantage of utilities built in to psql. In this lesson, we're going to explore the basic connection to Postgres using psql. Then, in following lessons we'll use psql to create objects within the cluster to act as the basis for our class.

I'm assuming you're following the lesson plan, so you'll be running this within a bash shell inside your container. However, you wouldn't run it any differently from the command line of your host OS. For our container as configured, here's how we would connect to it through psql:

