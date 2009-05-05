class CurrentlyPlayingFlag < ActiveRecord::Migration
  def self.up
    add_column :songs, :playing, :boolean
  end

  def self.down
    remove_column :songs, :playing
  end
end
