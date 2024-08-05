require "rails_helper"

describe "user login" do
  it "returns user info json with email and api key" do
    user = User.create(email: "jd@example.com", password: "password", api_key: "12345")
    request_body = {
      "email": "jd@example.com",
      "password": "password"
    }
    post "/api/v1/sessions", params: request_body

    expect(response.status).to eq(200)

    data = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(data).to be_a Hash
    expect(data).to have_key :id
    expect(data[:type]).to eq("user")
    expect(data[:attributes][:email]).to eq("jd@example.com")
    expect(data[:attributes][:api_key]).to eq("12345")
  end
  
  describe "sad path" do
    it "returns 401 bad credentials when password is incorrect" do
      user = User.create(email: "jd@example.com", password: "password", api_key: "12345")
      request_body = {
        "email": "jd@example.com",
        "password": "wrong"
      }
      post "/api/v1/sessions", params: request_body

      expect(response.status).to eq(401)

      errors = JSON.parse(response.body, symbolize_names: true)[:errors][0]

      expect(errors).to be_a Hash
      expect(errors[:code]).to eq(401)
      expect(errors[:message]).to eq("bad credentials")
    end

    it "returns 401 bad credentials when user doesn't exist" do
      user = User.create(email: "jd@example.com", password: "password", api_key: "12345")
      request_body = {
        "email": "jdmchugh@example.com",
        "password": "password"
      }
      post "/api/v1/sessions", params: request_body

      expect(response.status).to eq(401)

      errors = JSON.parse(response.body, symbolize_names: true)[:errors][0]

      expect(errors).to be_a Hash
      expect(errors[:code]).to eq(401)
      expect(errors[:message]).to eq("bad credentials")
    end
  end
end