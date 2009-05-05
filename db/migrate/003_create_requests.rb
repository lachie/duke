class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests, :id => false do |t|
      # Association
      t.column :user_id, :integer, :null => false
      t.column :song_id, :integer, :null => false
      
      # Timestamp
      t.column :created_at, :timestamp
    end
  end

  def self.down
    drop_table :requests
  end
end
