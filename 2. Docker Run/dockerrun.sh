## creating a PostgreSQL container

## First, create a directory on your machine to host the PostgreSQL volume
## substitute the path with your own, but make sure to use an absolute path
## Linux/MacOS
mkdir -p /home/grant/bu

## Windows/Powershell
mkdir C:/bu


## Creating a container
## Linux/MacOS
docker run -d --name StartingPostgreSQL \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD=%omePassw0rd \
    -v /home/grant/bu:/var/lib/postgresql/bu \
    -e POSTGRES_USER=postgres \
    postgres:latest
    
## Windows/Powershell
docker run -d --name StartingPostgreSQL `
    -p 5432:5432 `
    -e POSTGRES_PASSWORD=$omePassw0rd `
    -v C:/bu:/var/lib/postgresql/bu `
    -e POSTGRES_USER=postgres `
    postgres:latest


## In case of problems, this will stop and remove the container
docker stop StartingPostgreSQL
docker rm StartingPostgreSQL
