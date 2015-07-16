class AlbumsController < ApplicationController
  def show
    @album = Album.find(params[:id])
    render :show
  end

  def new
    @bands = Band.all
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      flash[:success] = ["#{@album.band.name} has published '#{@album.title}'!"]
      redirect_to band_url(@album.band_id)
    else
      flash.now[:errors] = ["Oops, something went wrong:"]
      flash[:errors].concat @album.errors.full_messages
      redirect_to bands_url
    end
  end


  private
  def album_params
    params.require(:album).permit(:title, :live?, :band_id)
  end
end
