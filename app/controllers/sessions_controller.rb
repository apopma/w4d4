class SessionsController < ApplicationController
  before_action :redirect_if_not_logged_in, except: [:new, :create]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params)

    if @user.nil?
      flash.now[:errors] = ["Wrong username/password combo"]
      render :new
    else
      login!(@user)
      flash[:success] = ["Logged in successfully as #{@user.user_name}"]
      redirect_to user_url(@user.id)
    end
  end

  def destroy
    logout!
    redirect_to root_url
  end

  def redirect_if_not_logged_in
    redirect_to new_session_url unless current_user
  end
end
