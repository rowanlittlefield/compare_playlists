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
    if response.code == '200'
      { code: response.code, body: JSON.parse(response.body) }
    else
      { code: response.code }
    end
  end
end
