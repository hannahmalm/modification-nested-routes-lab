module ArtistsHelper

  #display artist helper - pass in the song because we use that in the logic
  #1. look up the songs artist and see if it is nil
  #2. If it is nil, create a hyperlink called "Add Artist", which links to the edit path 
  #3. this will display as Add Artist : Song 
  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end

  #Display dropdown of artists, with name if editing through nested 
  #if path is nested, add a hidden field tag called song-artist id, and song artist 
  #if the path is not hidden, have select tag - list the options for the select tag
  def artist_select(song, path)
    if song.artist && path = "nested"
      hidden_field_tag "song[artist_id]", song.artist_id
    else 
      select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
    end 
  end 

  #Display name if editing through nested
  #need to pass in the song and path becasue youll use it in the logic
  # if the path is nested, display the artist name 
  def display_name(song, path)
    if song.artist && path == "nested"
      song.artist.name 
    end 
  end 

end
