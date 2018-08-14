class SpotifyClient
  attr_reader :playlist_id

  def initialize(playlist_id)
    @playlist_id = playlist_id
  end

  def self.api_response(playlist_id)
    client = SpotifyClient.new(playlist_id)
    client.send_request
  end

  def send_request
    uri = URI("https://api.spotify.com/v1/users/spotify/playlists/#{playlist_id}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(
      uri.path, {'Content-Type' => 'application/json'}
    )
    response = http.request(request)
  end
end
