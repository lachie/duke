class SongController < ApplicationController
  before_filter :set_user
  before_filter :find_song, :only => [ :show ]

  def index 
    # @songs = Song.list
    playlist
    render :action => 'playlist'
  end
  
  # OLD
  def playlist
    @songs        = Song.list
    @played_songs = Song.list_played
    @current      = Song.find_by_playing(true)
  end

  def player
    # render :text => "FUCK OFF, please" and return unless local_request?
    @song = Song.pop_next
  end

  def show
    @song = Song.find(params[:id])
    render :text => "You've just duked <span class='strong'> #{@song.title}</span> by " +
                    "<span class='strong'>#{@song.artist}</span> - #{@song.comment}"
  end

  def new
    @song = Song.new
  end

  def create 
    @song = @user.songs.build(params[:song])
    @song.content_type = 'audio/mp3'

    if @song.save
      flash.now[:notice] = "Your song has been added to the playlist"
      @song.add_tags
      redirect_to "/"
    else
      flash.now[:error] = "Sorry, something went wrong and we don't care"
      render :action => :new
    end
  end
  
  def library
    @songs = Song.find(:all)
  end

  private
    def find_song
      @song = Song.find(params[:id])
    end

end
