module TracksHelper
  def ugly_lyrics(lyrics)
    lyrics_ary = lyrics.split("\r\n")

    lyrics_ary.map! do |line|
      line = line.reverse.split("").push("♫ ").reverse.join("")
    end

    lyrics_ary.join("\r\n")
  end
end
