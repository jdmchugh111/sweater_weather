class RoadTripFacade
  def get_road_trip(origin, destination)
    service_1 = GeocoderService.new
    lat_long = (service_1.get_coords(destination))[:results][0][:locations][0][:latLng]
    coords = format_coords(lat_long)

    route = service_1.get_directions(origin, destination)[:route]
    if route[:routeError].present?
      travel_time = "impossible"
      weather_at_eta = {}
    else
      dt = format_dt(route[:time])
      hour = format_hour(route[:time])
      travel_time = route[:formattedTime]
      weather_at_eta = weather_hash(coords, dt, hour)
    end

    start_city = origin
    end_city = destination
    
    RoadTrip.new(start_city, end_city, travel_time, weather_at_eta)
  end

  def weather_hash(coords, dt, hour)
    array = timed_weather(coords, dt, hour)
    { datetime: array[0],
      temperature: array[1],
      condition: array[2]}
  end

  def timed_weather(coords, dt, hour)
    service_2 = WeatherService.new
    hour = service_2.hourly_weather(coords, dt, hour)[:forecast][:forecastday][0][:hour][0]
    [hour[:time], hour[:temp_f], hour[:condition][:text]]
  end

  def format_coords(lat_long)
    "#{lat_long[:lat]},#{lat_long[:lng]}"
  end

  def format_dt(time)
    eta = Time.now + time
    eta.strftime("%F")
  end

  def format_hour(time)
    eta = Time.now + time
    eta.strftime("%H")
  end
end