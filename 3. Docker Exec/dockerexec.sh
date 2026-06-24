## Opening an interactive bash shell inside a container
docker exec -it StartingPostgreSQL "bash"

## Getting a file listing inside the container
ls

## Validating we're in a Docker container
ls -l /.dockerenv

## Validating that we're in a PostgreSQL container
echo $POSTGRES_USER

## Leaving the shell
exit
