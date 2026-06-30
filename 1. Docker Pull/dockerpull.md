# Retrieving Docker images using Pull

The goal is to have a running PostgreSQL container. However, before a container can be created, the necessary image for that container must first be retrieved. It is possible to simply issue a `docker run` command, and if no image is found, it will automatically attempt to first `pull` that image.

However, it's a good practice to issue the `pull` command separately for several reasons:

- A `pull` command validates the image before execution, ensuring that malformed or malicious containers are not run
- By retrieving the image first, it's entirely possible to then work fully offline without the requirement of connectivity 
- A `run` command will run a local version of the image, not necessarily the latest image

For all these reasons, we'll use `pull` as the foundation for building out PostgreSQL containers.

## Docker Pull

There are a number of possible docker images. We'll start with the most generic PostgreSQL image. Later in the class we'll use a specialized image as well. Be sure you have an internet connection and your docker service is running, then run the following command:

```bash
docker pull postgres:latest
```

The part of the command `:latest` isn't actually necessary. By default, a `pull` command, if given no other instruction, will get the latest, stable, image. Worth repeating here, depending on the service you're running, you substitute `podman` or `nerdctl` for the `docker` command. All other aspects of the command will stay the same. Just to reiterate, the `latest` image will not be the most cutting edge version under development, but rather, the newest, stable release.

This command could take a while depending on the speed and bandwidth of your internet connection. In your command line interface, you should see progress on the download. When that completes, you're ready to validate the image.

To validate that the docker image was downloaded successfully, you can run the following:

```bash
docker images
```

On a brand new machine, you'll probably only see a REPOSITORY with one or two images, postgres and possibly hello-world. Also pay attention to the TAG column. Your postgres image should show a tag of 'latest'. If that's the case, you're ready to create a container.

### Pulling a specific image

If you wanted to have a specific version of PostgreSQL, it's possible by supplying the documented tag of that version. For a complete listing, the PostgreSQL community maintains the Docker PostgreSQL image on the docker hub, located here: https://hub.docker.com/_/postgres.

To pull a particular version, you merely need to supply it. As an optional example, here's how you would pull version 17.10:

```bash
docker pull postgres:17.10
```
