class Addownertosong < ActiveRecord::Migration
  def self.up
    add_column :songs, :user_id, :integer
  end

  def self.down
    remove_column :songs, :user_id
  end
end
