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
-- Description:	This stored procedure gets all the artists from a particular decade
-- =============================================
ALTER PROCEDURE sp_GetDecadeArtists
	-- Add the parameters for the stored procedure here
	@decadeID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT ma.artistName FROM dbo.MusicArtist ma INNER JOIN dbo.MusicArtistDecade mad ON ma.artistID = mad.artistID WHERE mad.decadeID = @decadeID

END
GO