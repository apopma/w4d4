class UsersController < ApplicationController
  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      flash[:success] = ["Welcome to MusicApp, #{@user.email}!"]
      redirect_to user_url(@user.id)
    else
      flash.now[:errors] = ["Sorry, something went wrong."]
      flash[:errors].concat @user.errors.full_messages
      render :new
    end
  end

  def destroy
    fail
  end

  def edit
    fail
  end

  def update
    fail
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
