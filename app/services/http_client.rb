require 'net/http'

class HTTPClient
  attr_reader :uri

  def initialize(uri)
    @uri = uri
  end

  def send_request
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(
      uri.path, {'Content-Type' => 'application/json'}
    )
    response = http.request(request)
    { code: response.code, body: JSON.parse(response.body)}
  end
end
