require "rails_helper"

RSpec.describe RoadTrip do
  it "exists", :vcr do
    facade = RoadTripFacade.new

    road_trip = facade.get_road_trip("boston,ma","new york,ny")
    expect(road_trip).to be_a RoadTrip

    expect(road_trip.id).to eq(nil)
    expect(road_trip.start_city).to eq("boston,ma")
    expect(road_trip.end_city).to eq("new york,ny")
    expect(road_trip.travel_time).to be_a String
    expect(road_trip.weather_at_eta).to be_a Hash
  end
end