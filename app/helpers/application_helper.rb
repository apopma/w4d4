module ApplicationHelper
    def current_user
      usr ||= User.find_by(session_token: session[:session_token])
      @current_user = usr
    end

    def logged_in?
      !!current_user
    end

    def login!(user)
      new_token = user.reset_session_token!
      session[:session_token] = new_token
    end

    def logout!
      current_user.reset_session_token!
      session[:session_token] = nil
      @current_user = nil
    end
end
