class ForecastFacade
  def get_forecast(location)
    service_1 = GeocoderService.new
    lat_long = (service_1.get_coords(location))[:results][0][:locations][0][:latLng]
    coords = format_coords(lat_long)
    weather_by_coords(coords)
  end

  def format_coords(lat_long)
    "#{lat_long[:lat]},#{lat_long[:lng]}"
  end

  def weather_by_coords(coords)
    service_2 = WeatherService.new
    forecast = service_2.get_weather(coords)
    Forecast.new(forecast)
  end
end