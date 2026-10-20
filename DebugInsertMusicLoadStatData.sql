DECLARE	@countSeventies int = 70
DECLARE	@countEighties int = 85
DECLARE	@countNineties int = 95
DECLARE	@countTwoThousands int = 105
DECLARE	@countTwoThousandTens int = 55
DECLARE	@countTwoThousandTwenties int = 35
DECLARE @countArtists int = 150
DECLARE @countSongs int = 445

DECLARE @prevSeventiesCount int = 0
DECLARE @prevEightiesCount int = 0
DECLARE @prevNinetiesCount int = 0
DECLARE @prevTwoThousandsCount int = 0
DECLARE @prevTwoThousandTensCount int = 0
DECLARE @prevTwoThousandTwentiesCount int = 0
DECLARE @prevTotalArtistsCount int = 0
DECLARE @prevTotalSongsCount int = 0

DECLARE @countSeventiesAdded int = 0
DECLARE @countEightiesAdded  int = 0
DECLARE @countNinetiesAdded  int = 0 
DECLARE @countTwoThousandsAdded int = 0
DECLARE @countTwoThousandTensAdded int = 0
DECLARE @countTwoThousandTwentiesAdded int = 0 
DECLARE @countSongsAdded int = 0
DECLARE @countArtistsAdded int = 0	
		

DECLARE @mlsMostRecentLoadStatID int

IF EXISTS (SELECT 1 FROM dbo.MusicLoadStatistic)
BEGIN

	SELECT @mlsMostRecentLoadStatID = musicLoadStatID FROM dbo.MusicLoadStatistic mls ORDER BY mls.dateAdded DESC

	SELECT 	
		   @prevSeventiesCount = mls.musicLoadStatCountSeventies,
		   @prevEightiesCount = mls.musicLoadStatCountEighties,
		   @prevNinetiesCount = mls.musicLoadStatCountNineties,
		   @prevTwoThousandsCount = mls.musicLoadStatCountTwoThousands,
		   @prevTwoThousandTensCount = mls.musicLoadStatCountTwoThousandTens,
		   @prevTwoThousandTwentiesCount = mls.musicLoadStatCountTwoThousandTwenties,
		   @prevTotalSongsCount = mls.musicLoadStatCountSongs,
		   @prevTotalArtistsCount = mls.musicLoadStatCountArtists
	FROM 
	dbo.MusicLoadStatistic mls
	WHERE mls.musicLoadStatID = @mlsMostRecentLoadStatID

	SET @countSeventiesAdded = @countSeventies - @prevSeventiesCount
	SET @countEightiesAdded = @countEighties - @prevEightiesCount
	SET @countNinetiesAdded = @countNineties - @prevNinetiesCount
	SET @countTwoThousandsAdded = @countTwoThousands - @prevTwoThousandsCount
	SET @countTwoThousandTensAdded = @countTwoThousandTens - @prevTwoThousandTensCount
	SET @countTwoThousandTwentiesAdded = @countTwoThousandTwenties - @prevTwoThousandTwentiesCount
	SET @countSongsAdded = @countSongs - @prevTotalSongsCount
	SET @countArtistsAdded = @countArtists - @prevTotalArtistsCount

END
ELSE
BEGIN
	SET @countSeventiesAdded = @countSeventies
	SET @countEightiesAdded = @countEighties
	SET @countNinetiesAdded = @countNineties
	SET @countTwoThousandsAdded = @countTwoThousands
	SET @countTwoThousandTensAdded = @countTwoThousandTens
	SET @countTwoThousandTwentiesAdded = @countTwoThousandTwenties
	SET @countSongsAdded = @countSongs
	SET @countArtistsAdded = @countArtists
END
	

SELECT @countSeventiesAdded,
		@countEightiesAdded,
		@countNinetiesAdded,
		@countTwoThousandsAdded,
		@countTwoThousandTensAdded,
		@countTwoThousandTwentiesAdded

INSERT INTO MusicLoadStatistic(musicLoadStatCountSeventies, 
								   musicLoadStatCountEighties, 
								   musicLoadStatCountNineties, 
								   musicLoadStatCountTwoThousands,
								   musicLoadStatCountTwoThousandTens,
								   musicLoadStatCountTwoThousandTwenties,
								   musicLoadStatCountSongs,
								   musicLoadStatCountArtists,
								   musicLoadStatCountSeventiesAdded,
								   musicLoadStatCountEightiesAdded,
								   musicLoadStatCountNinetiesAdded,
								   musicLoadStatCountTwoThousandsAdded,
								   musicLoadStatCountTwoThousandTensAdded,
								   musicLoadStatCountTwoThousandTwentiesAdded,
								   musicLoadStatCountArtistsAdded,
								   musicLoadStatCountSongsAdded,
								   dateAdded, 
								   dateModified)
				VALUES (@countSeventies, @countEighties, @countNineties, @countTwoThousands, @countTwoThousandTens, @countTwoThousandTwenties, @countSongs, @countArtists,
						@countSeventiesAdded, @countEightiesAdded, @countNinetiesAdded, @countTwoThousandsAdded, @countTwoThousandTensAdded, @countTwoThousandTwentiesAdded,
						@countArtistsAdded, @countSongsAdded,
				        getDate(), getDate())