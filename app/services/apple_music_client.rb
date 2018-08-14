require 'net/http'

class AppleMusicClient < HTTPClient
  def initialize(playlist_id)
    super(URI("https://api.music.apple.com/v1/catalog/us/playlists/#{playlist_id}"))
  end

  def self.fetch_tracks(playlist_id)
    client = AppleMusicClient.new(playlist_id)
    client.send_request
  end
end
