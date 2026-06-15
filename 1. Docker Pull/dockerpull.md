# Retrieving Docker images using Pull

The goal is to have a running PostgreSQL container. However, before a container can be created, the necessary image for that container must first be retrieved. It is possible to simply issue a `docker run` command, and if no image is found, it will automatically attempt to first `pull` that image.

However, it's a good practice to issue the `pull` command separately for several reasons:

- A `pull` command validates the image before execution, ensuring that malformed or malicious containers are not run
- By retrieving the image first, it's entirely possible to then work fully offline without the requirement of connectivity 
- A `run` command will run a local version of the image, not necessarily the latest image

For all these reasons, we'll use `pull` as the foundation for building out PostgreSQL containers.

## Docker Pull


