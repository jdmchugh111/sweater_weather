require "rails_helper"

describe "user registration" do
  it "creates a user when passed a proper request" do
    password = Faker::Internet.password
    request_body = {
      "email": Faker::Internet.email,
      "password": password,
      "password_confirmation": password
    }
    
    post "/api/v1/users", params: request_body

    expect(response.status).to eq(201)

    json = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(json[:id]).to be_a String
    expect(json[:type]).to eq("user")
    expect(json[:attributes][:email]).to be_a String
    expect(json[:attributes][:api_key]).to be_a String
  end

  describe "sad path" do
    it "will return a serialized 400 response when params are missing" do
      password = Faker::Internet.password
      request_body = {
        "password": password,
        "password_confirmation": password
      }
      
      post "/api/v1/users", params: request_body

      expect(response.status).to eq(400)

      json = JSON.parse(response.body, symbolize_names: true)[:errors][0]
      
      expect(json[:code]).to eq(400)
      expect(json[:message][:email]).to eq(["can't be blank"])
    end

    it "will return a serialized 400 response when passwords don't match" do
      password = Faker::Internet.password
      request_body = {
        "email": Faker::Internet.email,
        "password": password,
        "password_confirmation": "mismatch"
      }
      
      post "/api/v1/users", params: request_body

      expect(response.status).to eq(400)

      json = JSON.parse(response.body, symbolize_names: true)[:errors][0]

      expect(json[:code]).to eq(400)
      expect(json[:message][:password_confirmation]).to eq(["doesn't match Password"])
    end
  end
end