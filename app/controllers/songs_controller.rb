class SongsController < ApplicationController
  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        @songs = @artist.songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = @artist.songs.find_by(id: params[:id])
      if @song.nil?
        redirect_to artist_songs_path(@artist), alert: "Song not found"
      end
    else
      @song = Song.find(params[:id])
    end
  end

  #sets artist when nested route
  #validates artist when nested route
  #if the artist ID and the matching artist does not yet exist, redirect to the path and give the alert
  #sets the artist.id 
  def new
    if params[:artist_id] && !Artist.exists?(params[:artist_id])
        redirect_to artists_path, alert: "Artist not found"
    else 
      @song = Song.new(artist_id: params[:artist_id])
    end 
  end

  #Create accepts and sets artist_id
  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  #edit validates artist when nested
  #validates song for artist when nested - nested if statement
  #start by passing in the artist id, set the instance to the artist id
   #if there is an error and you send the wrong id - artist will be nil - validation if statement
   #if the artist is real and its found, then find the song 
  def edit
    if params[:artist_id]
      artist = Artist.find_by(id: params[:artist_id])
        if artist.nil? 
          redirect_to artists_path, alert: "Artist not found"
        else 
          @song = artist.songs.find_by(id: params[:id])
          redirect_to artist_songs_path(artist), alert: "Song not found" if @song.nil?
        end 
      else 
        @song = Song.find(params[:id])
      end 
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  #these params need to change to allow you to edit more things
  #add in the artist_id into the params to permit this to be edited
  def song_params
    params.require(:song).permit(:title, :artist_name, :artist_id)
  end
end

