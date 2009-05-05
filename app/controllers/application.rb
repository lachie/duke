class ApplicationController < ActionController::Base
  session :session_key => '_duke_session_id', :secret => 'de95e38b119ce62c6c4b0d9888b2ca41'

  private
  def set_user
    @user = User.find_by_id(session[:user_id])
  end

  def require_user
    @user = User.find_by_id(session[:user_id])

    unless @user
      respond_to do |format|
        format.html {redirect_to login_url}
        format.xml  {render :xml => ''}
      end
    end
  end

  def logged_in?
    @user
  end

  helper_method :logged_in?
end
