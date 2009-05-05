class CreateSongs < ActiveRecord::Migration
  def self.up
    create_table :songs do |t|
      # Basic
      t.column :title,  :string
      t.column :artist, :string

      # Counter
      t.column :requests_count, :integer, :null => false, :default => 0
    end
  end

  def self.down
    drop_table :songs
  end
end
