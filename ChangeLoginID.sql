USE [master];
GO
-- Create a new local login that won't conflict with Azure's admin name
CREATE LOGIN [MusicAppUser] WITH PASSWORD = 'dmdbpass!99', CHECK_POLICY = OFF;
GO

USE [Music];
GO
-- Map it as a normal database user
CREATE USER [MusicAppUser] FOR LOGIN [MusicAppUser] WITH DEFAULT_SCHEMA = [dbo];
ALTER ROLE db_datareader ADD MEMBER [MusicAppUser];
ALTER ROLE db_datawriter ADD MEMBER [MusicAppUser];
ALTER ROLE db_owner ADD MEMBER [MusicAppUser];
GO

-- Clean up the old local DMDBLogin user/login so it isn't included in the deployment package
DROP USER [DMDBLogin];
GO
USE [master];
DROP LOGIN [DMDBLogin];
GO
