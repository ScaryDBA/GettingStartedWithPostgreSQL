## creating a PostgreSQL container

## Linux/MacOS
docker run -d --name StartingPostgreSQL \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD=$omePassw0rd \
    -v /home/username/bu:/var/lib/postgresql/bu \
    -e POSTGRES_USER=postgres \
    postgres:latest
    
## Windows/Powershell
docker run -d --name StartingPostgreSQL `
    -p 5432:5432 `
    -e POSTGRES_PASSWORD=$omePassw0rd `
    -v C:/bu:/var/lib/postgresql/bu `
    -e POSTGRES_USER=postgres `
    postgres:latest