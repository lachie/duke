class RequestController < ApplicationController
  before_filter :require_user

  def duke
    @song = Song.find_by_id(params[:id])
    current_count = @user.request_song(@song)
    respond_to do |format|
      format.html { redirect_to playlist_url }
      format.js   { render :partial => 'song/song', :collection => Song.list }
    end
  end

  def diss
    @song = Song.find_by_id(params[:id])
    @user.diss(@song)
    respond_to do |format|
      format.html { redirect_to playlist_url } 
      format.js   { render :partial => 'song/song', :collection => Song.list }
    end
  end
end
