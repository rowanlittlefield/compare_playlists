class AppleMusicClient
  attr_reader :playlist_id

  def initialize(playlist_id)
    @playlist_id = playlist_id
  end

  def self.api_response(playlist_id)
    client = AppleMusicClient.new(playlist_id)
    client.send_request
  end

  def send_request
    uri = URI("https://api.music.apple.com/v1/catalog/us/playlists/#{playlist_id}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(
      uri.path, {'Content-Type' => 'application/json'}
    )
    response = http.request(request)
  end
end
