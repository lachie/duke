class Request < ActiveRecord::Base
  belongs_to :song, :counter_cache => true
  belongs_to :user
end
