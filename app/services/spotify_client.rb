require 'net/http'

class SpotifyClient < HTTPClient
  def initialize(playlist_id)
    super(URI("https://api.spotify.com/v1/users/spotify/playlists/#{playlist_id}"))
  end
end
