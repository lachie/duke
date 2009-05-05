class AddPlayedAt < ActiveRecord::Migration
  def self.up
    add_column :songs, :played_at, :datetime
  end

  def self.down
  end
end