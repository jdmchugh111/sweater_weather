class GeocoderService
  def conn
    conn = Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params[:key] = Rails.application.credentials.geocoder[:key]
    end
  end
  
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_coords(city)
    get_url("/geocoding/v1/address?location=#{city}")
  end

  def get_directions(origin, destination)
    get_url("/directions/v2/route?from=#{origin}&to=#{destination}")
  end
end