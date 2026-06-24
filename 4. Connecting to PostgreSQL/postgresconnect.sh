## Start the bash shell if needed
docker exec -it StartingPostgreSQL "bash"

## Connecting to the cluster
psql -d postgres -h localhost -U postgres


