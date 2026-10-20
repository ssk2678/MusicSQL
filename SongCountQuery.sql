SELECT TOP (1000) [songID]
      ,[artistName]
      ,[songName]      
      ,[songArtistID]
      ,[songDecadeID]      
  FROM [Music].[dbo].[MusicArtist] ma INNER JOIN [Music].[dbo].[MusicSong] ms ON ma.artistID = ms.songArtistID
  WHERE songDecadeID = 6
  ORDER BY artistName
  