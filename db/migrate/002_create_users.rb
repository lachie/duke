class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      # Basic
      t.column :nick,     :string, :null => false
      t.column :password, :string, :null => false
    end
  end

  def self.down
    drop_table :users
  end
end
