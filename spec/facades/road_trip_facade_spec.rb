require "rails_helper"

RSpec.describe RoadTripFacade do
  it "exists" do
    facade = RoadTripFacade.new
    expect(facade).to be_a RoadTripFacade
  end

  describe "#get_road_trip" do
    it "can return a RoadTrip object when given proper params", :vcr do
      facade = RoadTripFacade.new

      object = facade.get_road_trip("boston,ma", "new york,ny")
      expect(object).to be_a RoadTrip
    end
  end

  describe "#weather_hash" do
    it "can return a hash when given params", :vcr do
      facade = RoadTripFacade.new

      hash = facade.weather_hash("42.364506,-71.038887", "2024-08-08", "6")

      expect(hash).to be_a Hash
      expect(hash[:datetime]).to eq("2024-08-08 06:00")
      expect(hash[:temperature]).to be_a Float
      expect(hash[:condition]).to be_a String
    end
  end

  describe "#timed_weather" do
    it "can return an array with all 3 require pieces of data", :vcr do
      facade = RoadTripFacade.new

      array = facade.timed_weather("42.364506,-71.038887", "2024-08-08", "6")
      expect(array).to be_a Array
      expect(array[0]).to eq("2024-08-08 06:00")
      expect(array[1]).to be_a Float
      expect(array[2]).to be_a String
    end
  end
  
  describe "#format_coords" do
    it "can return a string with properly formatted long/lat", :vcr do
      facade = RoadTripFacade.new

      hash = { lat: 34.05357, lng: -118.24545}

      expect(facade.format_coords(hash)).to eq("34.05357,-118.24545")
    end
  end

  describe "#format_dt" do
    it "can format datetime" do
      facade = RoadTripFacade.new
      dt = facade.format_dt(15641)
      expect(dt).to be_a String
    end
  end

  describe "#format_hour" do
    it "can format hour" do
      facade = RoadTripFacade.new
      hour = facade.format_hour(15641)
      expect(hour).to be_a String
    end
  end
end