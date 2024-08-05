class Forecast
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather,
              :id
              
  def initialize(forecast)
    @id = nil
    @current_weather = current_weather_hash(forecast)
    @hourly_weather = hourly_weather_array(forecast[:forecast])
    @daily_weather = daily_weather_array(forecast[:forecast])
  end

  def current_weather_hash(forecast)
    hash = forecast[:current]
    { last_updated: hash[:last_updated],
      temperature: hash[:temp_f],
      feels_like: hash[:feelslike_f],
      humidity: hash[:humidity],
      uvi: hash[:uv],
      visibility: hash[:vis_miles],
      condition: hash[:condition][:text],
      icon: hash[:condition][:icon]}
  end

  def daily_weather_array(forecast)
    array = forecast[:forecastday]
    array.shift
    array.map do |day|
      make_daily_hash(day)
    end
  end

  def hourly_weather_array(forecast)
    current_day = forecast[:forecastday][0][:hour]
    current_day.map do |hour|
      make_hourly_hash(hour)
    end
  end

  def make_daily_hash(day)
    {date: day[:date],
    sunrise: day[:astro][:sunrise],
    sunset: day[:astro][:sunset],
    max_temp: day[:day][:maxtemp_f],
    min_temp: day[:day][:mintemp_f],
    condition: day[:day][:condition][:text],
    icon: day[:day][:condition][:icon]}
  end

  def make_hourly_hash(hour)
    {time: hour[:time],
    temperature: hour[:temp_f],
    condition: hour[:condition][:text],
    icon: hour[:condition][:icon]}
  end
end