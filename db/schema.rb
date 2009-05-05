# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080622070512) do

  create_table "requests", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "song_id",    :null => false
    t.datetime "created_at"
  end

  create_table "songs", :force => true do |t|
    t.string   "title"
    t.string   "artist"
    t.integer  "requests_count", :default => 0, :null => false
    t.string   "comment"
    t.integer  "user_id"
    t.integer  "size"
    t.string   "filename"
    t.string   "content_type"
    t.boolean  "playing"
    t.datetime "played_at"
  end

  create_table "users", :force => true do |t|
    t.string "nick",     :null => false
    t.string "password", :null => false
    t.string "ip"
  end

end
