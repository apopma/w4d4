class TracksController < ApplicationController
  def show
    @track = Track.find(params[:id])
    render :show
  end

  def new
    @album = Album.find(params[:album_id])
    @albums = @album.band.albums
    render :new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      flash[:success] = ["#{@track.band.name} has written '#{@track.title}'!"]
      redirect_to track_url(@track.id)
    else
      flash[:errors] = ["Oops, something went wrong:"]
      flash[:errors].concat @track.errors.full_messages
      redirect_to new_album_track_url(@track.album_id)
    end
  end

  private
  def track_params
    params.require(:track).permit(:title, :track_number, :album_id, :lyrics)
  end
end
