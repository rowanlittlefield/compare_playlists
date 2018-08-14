require 'net/http'

class HTTPClient
  attr_reader :uri

  def initialize(uri)
    @uri = uri
  end

  def self.api_response(playlist_id)
    client = self.class.new(playlist_id)
    client.send_request
  end

  def send_request
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(
      uri.path, {'Content-Type' => 'application/json'}
    )
    response = http.request(request)
  end
end
