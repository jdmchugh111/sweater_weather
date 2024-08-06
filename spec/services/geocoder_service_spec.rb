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

  describe "#get_directions" do
    it "can return necessary route information", :vcr do
      service = GeocoderService.new

      response = service.get_directions("boston,ma", "new york,ny")

      expect(response[:route]).to be_a Hash
      expect(response[:route][:formattedTime]).to be_a String
      expect(response[:route][:time]).to be_a Integer
    end
  end
end