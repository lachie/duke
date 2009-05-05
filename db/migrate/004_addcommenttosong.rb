class Addcommenttosong < ActiveRecord::Migration
  def self.up
    add_column :songs, :comment, :string
  end

  def self.down
    remove_column :songs, :comment
  end
end
