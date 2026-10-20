-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sabeeh Khan
-- Create date: 02/02/2021
-- Description:	This stored procedure gets all the songs from a particular decade
-- =============================================
ALTER PROCEDURE sp_GetArtistSongs
	-- Add the parameters for the stored procedure here
	@artistID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM dbo.MusicSong ms where ms.songArtistID = @artistID

END
GO