require 'net/http'

class AppleMusicClient < HTTPClient
  def initialize(playlist_id)
    super(URI("https://api.music.apple.com/v1/catalog/us/playlists/#{playlist_id}"))
  end
end
