require "rails_helper"

describe BookService do
  describe "#search_books" do
    it "can return json data about books based on a keyword", :vcr do
      service = BookService.new
      response = service.search_books("denver,co")

      expect(response).to be_a Hash

      expect(response).to have_key :numFound
      expect(response[:numFound]).to be_a Integer

      expect(response).to have_key :docs
      expect(response[:docs]).to be_a Array
      first_book = response[:docs][0]

      expect(first_book).to have_key :isbn
      expect(first_book[:isbn]).to be_a Array
      expect(first_book).to have_key :title
      expect(first_book[:title]).to be_a String
      expect(first_book).to have_key :publisher
      expect(first_book[:publisher]).to be_a Array
    end
  end
end