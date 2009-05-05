require "mp3info"

class Song < ActiveRecord::Base
  has_many :requests, :dependent => :destroy
  belongs_to :user

  has_attachment  :content_type   => 'audio/mp3', 
                  :storage        => :file_system,
                  :max_size       => 20.megabytes,
                  :tempfile_path  => "/tmp"
                   
  validates_as_attachment
  
  def add_tags
    begin
      mp3 = Mp3Info.open(File.join(RAILS_ROOT, 'public', self.public_filename))
      mp3tag = [mp3.tag, mp3.tag1, mp3.tag2].detect { |tags| !tags.blank? }
      
      raise "no mp3 tags found"
    
      self.title = mp3tag.title || mp3tag.TT2 || public_filename.split('/').last.split('.').first.capitalize
      self.artist = (mp3tag.artist || mp3tag.TP1 || "").strip
    
      self.title.gsub!(/\000/, '')
    
      self.save
    rescue Mp3InfoError, RuntimeError
      puts "no tags... #{$!}"
            
      self.title = self.public_filename.split('/').last.split('.').first.capitalize
      self.save
    end
  end
  
  
  TIME_LIMIT = 30.minutes.to_i
  def dukeable?(current_user)
    return false unless current_user
    
    time = self.played_at ? (Time.now.to_i - self.played_at.to_f > TIME_LIMIT) : true
    
    time && !current_user.requested?(self)
  end

  def requested_by?(user)
    self.requests.collect(&:user_id).include?(user.id)
  end

  def reset_requests
    requests.destroy_all
  end
  
  def self.pop_next
    Song.find_all_by_playing(true).each do |s|
      s.update_attributes(:playing => false, :played_at => DateTime.now)
    end

    song = Song.list.first
    
    unless song
      Song.update_all('played_at=null')
      song = Song.list.first
    end
    
    song.update_attributes(:playing => true, :played_at => DateTime.now)

    song.requests.clear
    Song.connection.execute("update songs set requests_count=0 where id=#{song.id}")

    song
  end

  def self.list
    self.find(:all,
      :conditions => "(playing = 0 or playing IS NULL) and (played_at IS NULL or UNIX_TIMESTAMP()-UNIX_TIMESTAMP(played_at) > #{TIME_LIMIT})",
      :order      => 'requests_count desc, played_at, songs.id ASC',
      :include    => [ :requests, :user ])
  end
  
  def self.list_played
    self.find(:all,
      :conditions => "(playing = 0 or playing IS NULL) and (played_at IS NOT NULL and UNIX_TIMESTAMP()-UNIX_TIMESTAMP(played_at) <= #{TIME_LIMIT})",
      :order      => 'requests_count desc, played_at, songs.id ASC',
      :include    => [ :requests, :user ])
  end

  def self.list_without_playing
    self.find(
      :all,
      :conditions => "playing = 0 or playing IS NULL",
      :order      => "requests_count desc, songs.id ASC",
      :include    => [:requests, :user]
    )
  end

  def user_name
    user.nick
  end

  def to_xml(options = {})
    defaults = {:dasherize => false, :only    => [:id, :title, :artist, :comment, :requests_count],
                                     :methods => [:url, :user_name]}
    return super(defaults.merge(options))
  end
end
