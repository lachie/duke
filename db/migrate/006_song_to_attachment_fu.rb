class SongToAttachmentFu < ActiveRecord::Migration
  def self.up
    add_column :songs, :size, :integer
    add_column :songs, :filename, :string
    add_column :songs, :content_type, :string
  end

  def self.down
    remove_column :songs, :size
    remove_column :songs, :filename
    remove_column :songs, :content_type
  end
end
