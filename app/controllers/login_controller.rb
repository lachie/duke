class LoginController < ApplicationController
  def login
    if request.post?
      @user = User.authenticate(params[:user][:nick], params[:user][:password])

      if @user
        flash[:notice] = 'Welcome back'
        session[:user_id] = @user.id
      end
      redirect_to playlist_url
    end
  end

  def logout
    reset_session
    flash[:notice] = 'You have logged out sucessfully!'
    redirect_to playlist_url
  end

  def register
    if request.post?
      return if User.find_by_ip(request.remote_ip.to_s)
      @user = User.new(params[:user])
      @user.ip = request.remote_ip.to_s

      if @user.save
        flash[:notice] = "Thanks for signing up, #{@user.nick}"
        session[:user_id] = @user.id
        redirect_to playlist_url
      end
    end
  end
end
