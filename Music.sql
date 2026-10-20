USE Music

/*
	-- Author: Sabeeh S. Khan
	-- Date: 01/31/2021
	-- This script creates tables for the Music Database
*/
BEGIN TRY

	BEGIN TRAN
	-- Drop Tables if they exist

	-- Create Tables
	
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MusicStatistic]') AND Type in (N'U'))
		DROP TABLE [dbo].[MusicStatistic];
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MusicArtistDecade]') AND Type in (N'U'))
		DROP TABLE [dbo].[MusicArtistDecade];
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MusicSong]') AND Type in (N'U'))
		DROP TABLE [dbo].[MusicSong];
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MusicDecade]') AND Type in (N'U'))
		DROP TABLE [dbo].[MusicDecade];
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MusicArtist]') AND Type in (N'U'))
		DROP TABLE [dbo].[MusicArtist];
	

	-----------------------------------------------------------------------------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------------------------------------------

	-- Artist Table
	CREATE TABLE MusicArtist (artistID int IDENTITY(1, 1) not null, artistName varchar(100), dateAdded DATETIME, dateModified DATETIME CONSTRAINT pk_Artist PRIMARY KEY CLUSTERED(artistID));

	-----------------------------------------------------------------------------------------------------------------------------------------------

	-- Decade Table
	CREATE TABLE MusicDecade (decadeID int IDENTITY(1,1), decadeName varchar(25), dateAdded DATETIME, dateModified DATETIME CONSTRAINT pk_Decade PRIMARY KEY CLUSTERED(decadeID));
	INSERT INTO MusicDecade(decadeName, dateAdded, dateModified)
		   VALUES('1970s', GetDate(), GetDate()), ('1980s', GetDate(), GetDate()), ('1990s', GetDate(), GetDate()), ('2000s', GetDate(), GetDate()), ('2010s', GetDate(), GetDate()), ('2020s', GetDate(), GetDate()) 

	-----------------------------------------------------------------------------------------------------------------------------------------------

	-- ArtistDecade Table
	CREATE TABLE MusicArtistDecade (artistDecadeID int IDENTITY(1, 1) not null, artistID int, decadeID int, dateAdded DATETIME, dateModified DATETIME CONSTRAINT pk_ArtistDecade PRIMARY KEY CLUSTERED(artistDecadeID));

	-----------------------------------------------------------------------------------------------------------------------------------------------

	-- Song Table
	CREATE TABLE MusicSong (songID int IDENTITY(1,1) not null, songName varchar(100), songArtistID int, songDecadeID int, dateAdded DATETIME, dateModified DATETIME  
																																  CONSTRAINT pk_Song PRIMARY KEY CLUSTERED(songID), 
																																  CONSTRAINT fk_SongArtistID FOREIGN KEY (songArtistID) REFERENCES MusicArtist(artistID),
																																  CONSTRAINT fk_SongCategoryID FOREIGN KEY (songDecadeID) REFERENCES MusicDecade(decadeID));
																															  
	------------------------------------------------------------------------------------------------------------------------------------------------

	-- Stat Table
	CREATE TABLE MusicStatistic (musicStatID int IDENTITY(1, 1) not null, musicStatDecadeID int not null, musicStatArtistID int not null, musicStatSongID int not null, dateAdded DATETIME, dateModified DATETIME
																																				CONSTRAINT pk_Stat PRIMARY KEY CLUSTERED(musicStatID),
																																				CONSTRAINT fk_StatDecadeID FOREIGN KEY (musicStatDecadeID) REFERENCES MusicDecade(decadeID),
																																				CONSTRAINT fk_StatArtistID FOREIGN KEY (musicStatArtistID) REFERENCES MusicArtist(artistID),
																																				CONSTRAINT fk_StatSongID FOREIGN KEY (musicStatSongID) REFERENCES MusicSong(songID))
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