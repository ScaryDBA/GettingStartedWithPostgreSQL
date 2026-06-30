## Copy the file from the lesson to the volume directory on your machine
## Linux/MacOS

cp "5. Creating a Role/creatingrole.sql" /mnt/c/Users/grant/bu

## Windows/Powershell
Copy-Item "5. Creating a Role\creatingrole.sql" C:\Users\grant\bu


## Validate that the file is in the container volume directory
## If you need to first connect to the container, use the following command:
## docker exec -it StartingPostgreSQL bash

ls /var/lib/postgresql/bu


## Run the psql command to create the role using the SQL file

psql -d postgres -h localhost -U postgres -f "/var/lib/postgresql/bu/creatingrole.sql"


## Validating that the role was created successfully

## leave bash
exit

## copy the file
cp "5. Creating a Role/creatingrolevalidation.sql" /mnt/c/Users/grant/bu

## go back into bash
docker exec -it StartingPostgreSQL "bash"

## run the query
psql -d postgres -h localhost -U postgres -f "/var/lib/postgresql/bu/creatingrolevalidation.sql"


## Testing the role

psql -d postgres -h localhost -U radiodev -c "\conninfo"
