class User < ActiveRecord::Base
  # Association
  has_many :songs
  has_many :requests

  # Requests
  def request_song(song)
    Request.find_or_create_by_user_id_and_song_id(self.id, song.id)
    song.reload
    return song.requests_count
  end
  
  def requested?(song)
    song.requests.any? { |req| req.user_id == self.id }
  end

  def diss(song)
    Diss.find_or_create_by_user_id_and_song_id(self.id, song.id)
  end

  # Authentication
  def self.authenticate(nick, password)
    self.find_by_nick_and_password(nick, password)
  end

  def requested_song_ids
    requests = Request.find_all_by_user_id(self.id)
    requests.collect  {| req | req.song_id }
  end
  
end
