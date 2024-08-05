require "rails_helper"

RSpec.describe BookSearchFacade do
  it "exists" do
    facade = BookSearchFacade.new
    expect(facade).to be_a BookSearchFacade
  end

  describe "#book_search" do
    it "can return a Books object when given proper params", :vcr do
      facade = BookSearchFacade.new

      object = facade.book_search("denver,co", "5")
      expect(object).to be_a Books
    end
  end

  describe "#format_coords" do
    it "can return a string with properly formatted long/lat", :vcr do
      facade = BookSearchFacade.new

      hash = { lat: 34.05357, lng: -118.24545}

      expect(facade.format_coords(hash)).to eq("34.05357,-118.24545")
    end
  end

  describe "#forecast_by_coords" do
    it "can return an array with basic forecast info", :vcr do
      facade = BookSearchFacade.new

      forecast_data = facade.forecast_by_coords("34.05357,-118.24545")

      expect(forecast_data).to be_a Array
      expect(forecast_data[0]).to be_a String
      expect(forecast_data[1]).to be_a Float
    end
  end
end