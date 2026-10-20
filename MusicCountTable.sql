USE Music

/*
	-- Author: Sabeeh S. Khan
	-- Date: 10/15/2026
	-- This script creates tables for the Music Database
*/
BEGIN TRY

	BEGIN TRAN
	-- Drop Tables if they exist

	-- Create Total Statistics Table
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MusicCount]') AND Type in (N'U'))
		DROP TABLE [dbo].[MusicCount];

	-- Counts Table
	CREATE TABLE MusicCount (musicCountID int IDENTITY(1, 1) not null, 
	                         totalSeventiesSongs int not null, 
							 totalEightiesSongs int not null, 
							 totalNinetiesSongs int not null, 
							 totalTwoThousandsSongs int not null, 
							 totalTwoThousandTensSongs int not null, 
							 totalTwoThousandTwentiesSongs int not null,  
							 totalSongs int not null,
							 totalArtists int not null,
							 dateAdded DATETIME, 
							 dateModified DATETIME,

		CONSTRAINT pk_MusicCount PRIMARY KEY CLUSTERED(musicCountID))
																																				

	COMMIT																																
END TRY

BEGIN CATCH

	PRINT ERROR_MESSAGE();
	PRINT 'Rolling back Transaction';
	IF @@TRANCOUNT > 0 BEGIN
		ROLLBACK;
	END;

	THROW 50001, 'THERE WAS AN ERROR IN THE TABLE CREATION PROCESS', 1

END CATCH;