-- Creating a role with password

CREATE ROLE radiodev WITH
    LOGIN
    CREATEDB
    PASSWORD '*securepassword*';
    
