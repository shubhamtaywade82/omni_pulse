# frozen_string_literal: true

class DhanClient
  API_ROOT = 'https://api.dhan.co/v2'

  def initialize
    @headers = {
      'access-token' => ENV.fetch('DHAN_ACCESS_TOKEN'),
      'client-id' => ENV.fetch('DHAN_CLIENT_ID'),
      'Content-Type' => 'application/json'
    }
    @http = HTTPX.plugin(:retries).with(headers: @headers)
  end

  def holdings
    @http.get("#{API_ROOT}/holdings").json
  end

  def place_order(body)
    @http.post("#{API_ROOT}/orders", json: body).json
  end
end
