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

  def edit
    @track = Track.find(params[:id])
    @albums = @track.band.albums
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    @album = @track.album # same hack as in albums#update

    if @track.update_attributes(track_params)
      flash[:success] = ["'#{@track.title}' was successfully edited!"]
      redirect_to track_url(@track.id)
    else
      flash[:errors] = ["Oops. Something went wrong:"]
      flash[:errors].concat @track.errors.full_messages
      redirect_to edit_track_url(@track.id)
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy!
    flash[:success] = ["'#{@track.title}' didn't make it past QA."]
    redirect_to album_url(@track.album_id)
  end

  private
  def track_params
    params.require(:track)
    .permit(:title, :track_number, :bonus?, :album_id, :lyrics)
  end
end
