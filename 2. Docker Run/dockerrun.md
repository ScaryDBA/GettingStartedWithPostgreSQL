# Creating a Container Using Docker Run

Once an image has been created locally, you can now use that image to create containers. As was stated in the last lesson, you can simply use `docker run` to both pull the image and create the container. Either way, we'll need to break down the core requirements for creating a PostgreSQL container using `docker run`. This is the full command that we'll be using:

`docker run -d --name APRSReporter `
    -p 5432:5432 `
    -e POSTGRES_PASSWORD=*cthulhu1988 `
    -v C:/bu:/var/lib/postgresql/bu `
    -e POSTGRES_USER=postgres `
    postgres:latest`