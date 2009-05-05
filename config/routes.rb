ActionController::Routing::Routes.draw do |map|
  map.resources :songs, :controller => :song, :member => { :duke => :any }
  map.connect '', :controller => 'song', :action => 'playlist'

  # Login
  map.with_options(:controller => 'login') do |login_map|
    login_map.login    'login', :action => 'login'
    login_map.logout    'logout', :action => 'logout'
    login_map.register 'register', :action => 'register'
  end

  # Song
  map.with_options(:controller => 'song') do |song_map|
    song_map.playlist 'playlist', :action => 'playlist'
    song_map.upload   'upload',   :action => 'upload'
    # Make this DRY
    song_map.connect  'playlist.:format', :action => 'playlist'
  end

  # Request
  map.with_options(:controller => 'request') do |request_map|
    request_map.request 'duke/:id', :action => 'duke'
    request_map.request 'diss/:id', :action => 'diss'
    # Make this DRY
    request_map.connect 'duke.:format', :action => 'duke'
    request_map.connect 'diss.:format', :action => 'diss'
  end

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
