require "rails_helper"

describe GeocoderService do
  describe "get_coords" do
    it "can return coordinates when given a location", :vcr do
      service = GeocoderService.new

      response = service.get_coords("boston,ma")

      expect(response).to be_a Hash
      expect(response).to have_key :results
      expect(response[:results][0]).to have_key :locations
      expect(response[:results][0][:locations][0]).to have_key :latLng
    end
  end
end