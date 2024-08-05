class WeatherService
  def conn
    conn = Faraday.new(url: "http://api.weatherapi.com") do |faraday|
      faraday.params[:key] = Rails.application.credentials.weather[:key]
    end
  end
  
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_weather(coords)
    get_url("/v1/forecast.json?q=#{coords}&days=6")
  end

  def get_forecast(coords)
    get_url("/v1/forecast.json?q=#{coords}")
  end
end