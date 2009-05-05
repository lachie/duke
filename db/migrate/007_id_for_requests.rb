class IdForRequests < ActiveRecord::Migration
  def self.up
    add_column :requests, :id, :primary_key
  end

  def self.down
    remove_column :requests, :id
  end
end
