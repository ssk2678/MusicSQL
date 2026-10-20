-- 1. Switch to master to clean up the login
USE [master];
GO
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'DMDBLogin')
    DROP LOGIN [DMDBLogin];
GO

-- 2. Create the server login using your app's exact password
CREATE LOGIN [DMDBLogin] WITH PASSWORD = 'dmdbpass!99', CHECK_POLICY = OFF; 
GO

-- 3. Move to the Music DB to map the user cleanly
USE [Music];
GO
-- Explicitly make your Windows account the primary owner so DMDBLogin doesn't conflict
ALTER AUTHORIZATION ON DATABASE::[Music] TO [SSK0878-122024\notsa];
GO

-- 4. Recreate the database user mapping cleanly
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'DMDBLogin')
    DROP USER [DMDBLogin];
GO
CREATE USER [DMDBLogin] FOR LOGIN [DMDBLogin] WITH DEFAULT_SCHEMA = [DMDBLogin];
GO

-- 5. Give the app permissions to load data into the tables
ALTER ROLE db_datareader ADD MEMBER [DMDBLogin];
ALTER ROLE db_datawriter ADD MEMBER [DMDBLogin];
ALTER ROLE db_owner ADD MEMBER [DMDBLogin]; -- Added to ensure your batch process can create/alter tables if needed
GO
