require "rails_helper"

RSpec.describe Forecast do
  it "exists", :vcr do
    facade = ForecastFacade.new

    forecast = facade.get_forecast("boston,ma")
    expect(forecast).to be_a Forecast

    expect(forecast.id).to eq(nil)
    expect(forecast.current_weather).to be_a Hash 
    expect(forecast.daily_weather).to be_a Array
    expect(forecast.hourly_weather).to be_a Array
  end
end