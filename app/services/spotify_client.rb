require 'net/http'

class SpotifyClient < HTTPClient
  def initialize(playlist_id)
    super(URI("https://api.spotify.com/v1/users/spotify/playlists/#{playlist_id}"))
  end

  def self.fetch_tracks(playlist_id)
    client = SpotifyClient.new(playlist_id)
    client.send_request
  end
end
