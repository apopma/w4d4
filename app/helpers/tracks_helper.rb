module TracksHelper
  def ugly_lyrics(lyrics)
    lyrics_ary = lyrics.split("\r\n")
    lyrics_ary.map! { |line| line = "♫ " + line }.join("\r\n")
  end
end
