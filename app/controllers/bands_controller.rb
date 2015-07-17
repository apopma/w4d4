class BandsController < ApplicationController
  before_action :ensure_logged_in, except: :index

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
      flash.now[:errors] = ["Oops. Something went wrong:"]
      flash[:errors].concat @band.errors.full_messages
      render :new
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy!
    flash[:success] = ["#{@band.name} has broken up."]
    redirect_to bands_url
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    old_name = @band.name

    if @band.update_attributes(band_params)
      flash[:success] = ["#{old_name} has been renamed to #{@band.name}."]
      redirect_to band_url(@band.id)
    else
      flash.now[:errors] = "Oops. Something went wrong:"
      flash[:errors].concat @band.errors.full_messages
      render :edit
    end
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end

  def ensure_logged_in
    unless logged_in?
      flash[:errors] = ["Please login before doing that."]
      redirect_to new_session_url
    end
  end
end
