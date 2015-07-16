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

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    @bands = Band.all # hacky thing to fix missing @bands on redirect
    old_name = @album.title

    if @album.update_attributes(album_params)
      flash[:success] = ["'#{old_name}' has been re-released as '#{@album.title}!'"]
      redirect_to album_url(@album.id)
    else
      flash[:errors] = ["Oops. Something went wrong:"]
      flash[:errors].concat @album.errors.full_messages
      redirect_to edit_album_url(@album.id)
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy!
    flash[:success] = ["All copies of #{@album.title} have been destroyed in a fit of artistic pique."]
    redirect_to band_url(@album.band_id)
  end

  private
  def album_params
    params.require(:album).permit(:title, :live?, :band_id)
  end
end
