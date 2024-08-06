require "rails_helper"

describe WeatherService do
  describe "#get_weather" do
    it "can get weather json for current day +5", :vcr do
      service = WeatherService.new
      response = service.get_weather("34.05357,-118.24545")

      expect(response).to be_a Hash
      expect(response[:location][:name]).to eq("Los Angeles")
      expect(response).to have_key :current
      expect(response).to have_key :forecast
      expect(response[:forecast]).to have_key :forecastday
      expect(response[:forecast][:forecastday]).to be_a Array
      all_days = response[:forecast][:forecastday]
      expect(all_days.count).to eq(6)
      first_day = response[:forecast][:forecastday][0]
      expect(first_day).to have_key :date
      expect(first_day).to have_key :day
      expect(first_day).to have_key :astro
      expect(first_day).to have_key :hour
    end
  end
  describe "#hourly_weather" do
    it "can get exact hour's weather with proper params", :vcr do
      service = WeatherService.new
      response = service.hourly_weather("34.05357,-118.24545", "2024-08-09", "18")

      expect(response).to be_a Hash
      expect(response[:location][:name]).to eq("Los Angeles")
      expect(response[:forecast][:forecastday][0][:hour][0]).to be_a Hash
      arrival_hour = response[:forecast][:forecastday][0][:hour][0]
      expect(arrival_hour[:time]).to eq("2024-08-09 18:00")
      expect(arrival_hour[:temp_f]).to be_a Float
      expect(arrival_hour[:condition][:text]).to be_a String
    end
  end
end