require "rails_helper"

RSpec.describe ForecastFacade do
  it "exists" do
    facade = ForecastFacade.new
    expect(facade).to be_a ForecastFacade
  end

  describe "#get_forecast" do
    it "can return a forecast object when given a location", :vcr do
      facade = ForecastFacade.new

      object = facade.get_forecast("boston,ma")
      expect(object).to be_a Forecast
    end
  end

  describe "#format_coords" do
    it "can return a string with properly formatted long/lat", :vcr do
      facade = ForecastFacade.new

      hash = { lat: 34.05357, lng: -118.24545}

      expect(facade.format_coords(hash)).to eq("34.05357,-118.24545")
    end
  end

  describe "#weather_by_coords" do
    it "can return a forecast object when given coordinates", :vcr do
      facade = ForecastFacade.new

      expect(facade.weather_by_coords("34.05357,-118.24545")).to be_a Forecast
    end
  end
end