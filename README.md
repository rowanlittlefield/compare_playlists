# Compare Playlists

This app acts as an api webservice with a single route `/compare-playlists`. The webservice will respond to a url of the form `https://<your-domain>.com/compare-playlists?spotify=<spotify_playlist_id>&appleMusic=<apple_music_playlist_id>` and will subsequently issue requests to retrieve the playlists found in the Spotify API with an id of `<spotify_playlist_id>` and in the AppleMusic API with an id of `<apple_music_playlist_id>`. The api action will then issue a response in json format with 'count' key pointing to the number of shared tracks found between the Spotify and AppleMusic playlists. 

The controller for the single route web app can be found in `app/controllers/api/playlists_controller.rb`. The http client classes can be found in the `app/services` directory. The unit tests for the single controller action can be found in `spec/controllers/api/playlists_controller.rb`. After cloning/downloading this directory, run `bundle install` in the root directory of the project in the terminal in order to download and install all of the gems/dependencies for the project. The specs for the project can then be run by running `bundle exec rspec` in the root directory. 
