require "rails_helper"

describe "weather search" do
  it "returns a properly formatted hash of weather data", :vcr do
    get "/api/v1/forecast?location=boston,ma"

    expect(response).to be_successful

    weather = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(weather).to be_a Hash
    expect(weather[:id]).to eq(nil)
    expect(weather[:type]).to eq("forecast")
    expect(weather[:attributes]).to have_key :current_weather
    expect(weather[:attributes]).to have_key :daily_weather
    expect(weather[:attributes]).to have_key :hourly_weather

    expect(weather[:attributes][:current_weather][:last_updated]).to be_a String
    expect(weather[:attributes][:current_weather][:temperature]).to be_a Float
    expect(weather[:attributes][:current_weather][:feels_like]).to be_a Float
    expect(weather[:attributes][:current_weather][:humidity]).to be_a Integer
    expect(weather[:attributes][:current_weather][:uvi]).to be_a Float
    expect(weather[:attributes][:current_weather][:visibility]).to be_a Float
    expect(weather[:attributes][:current_weather][:condition]).to be_a String
    expect(weather[:attributes][:current_weather][:icon]).to be_a String
    
    daily = weather[:attributes][:daily_weather]
    expect(daily.count).to eq(5)
    first_day = daily[0]
    expect(first_day[:date]).to be_a String
    expect(first_day[:sunrise]).to be_a String
    expect(first_day[:sunset]).to be_a String
    expect(first_day[:max_temp]).to be_a Float
    expect(first_day[:min_temp]).to be_a Float
    expect(first_day[:condition]).to be_a String
    expect(first_day[:icon]).to be_a String

    hourly = weather[:attributes][:hourly_weather]
    expect(hourly.count).to eq(24)
    first_hour = hourly[0]
    expect(first_hour[:time]).to be_a String
    expect(first_hour[:temperature]).to be_a Float
    expect(first_hour[:condition]).to be_a String
    expect(first_hour[:icon]).to be_a String
  end
end

describe "sad path" do
  it "returns a 400 bad request if I don't include the location parameter", :vcr do
    get "/api/v1/forecast"

    expect(response).to_not be_successful

    error = JSON.parse(response.body, symbolize_names: true)[:errors][0]

    expect(error).to have_key :code
    expect(error).to have_key :message
    expect(error[:code]).to eq(400)
    expect(error[:message]).to eq("Param missing")
  end
end