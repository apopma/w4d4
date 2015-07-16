class BandsController < ApplicationController
  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      flash[:success] = ["#{@band.name} will make it big someday! Probably."]
      redirect_to band_url(@band.id)
    else
      flash[:errors] = ["Oops. Something went wrong:"]
      render :new
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy!
    flash[:success] = ["#{@band.name} has broken up."]
    redirect_to bands_url
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end
end
