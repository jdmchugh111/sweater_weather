require "rails_helper"

describe "road trip post request" do
  it "returns a properly formatted response of road trip data", :vcr do
    User.create(email: "jd@example.com", password: "password", api_key: "12345")
    request_body = {
      "origin": "New York, NY",
      "destination": "Los Angeles, CA",
      "api_key": "12345"
    }
    post "/api/v1/road_trip", params: request_body

    expect(response).to be_successful

    road_trip = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(road_trip).to be_a Hash
    expect(road_trip[:id]).to eq(nil)
    expect(road_trip[:type]).to eq("road_trip")
    expect(road_trip[:attributes][:start_city]).to eq("New York, NY")
    expect(road_trip[:attributes][:end_city]).to eq("Los Angeles, CA")
    expect(road_trip[:attributes][:travel_time]).to be_a String
    weather = road_trip[:attributes][:weather_at_eta]
    expect(weather[:datetime]).to be_a String
    expect(weather[:temperature]).to be_a Float
    expect(weather[:condition]).to be_a String
  end

  describe "sad path" do
    it "will return 401 if api key doesn't match an existing or is not present", :vcr do
      request_body = {
      "origin": "New York, NY",
      "destination": "Los Angeles, CA",
      "api_key": "12345"
      }
      post "/api/v1/road_trip", params: request_body

      error = JSON.parse(response.body, symbolize_names: true)[:errors][0]

      expect(error[:code]).to eq(401)
      expect(error[:message]).to eq("bad credentials")
    end

    it "will return a modified response if drive is impossible", :vcr do
      User.create(email: "jd@example.com", password: "password", api_key: "12345")
      request_body = {
        "origin": "New York, NY",
        "destination": "London, UK",
        "api_key": "12345"
      }
      post "/api/v1/road_trip", params: request_body

      expect(response).to be_successful

      road_trip = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(road_trip).to be_a Hash
      expect(road_trip[:id]).to eq(nil)
      expect(road_trip[:type]).to eq("road_trip")
      expect(road_trip[:attributes][:start_city]).to eq("New York, NY")
      expect(road_trip[:attributes][:end_city]).to eq("London, UK")
      expect(road_trip[:attributes][:travel_time]).to eq("impossible")
      expect(road_trip[:attributes][:weather_at_eta]).to eq({})
    end
  end
end