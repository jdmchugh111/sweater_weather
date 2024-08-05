require "rails_helper"

RSpec.describe Books do
  it "exists", :vcr do
    facade = BookSearchFacade.new

    books_poro = facade.book_search("denver,co", "5")
    expect(books_poro).to be_a Books

    expect(books_poro.id).to eq(nil)
    expect(books_poro.destination).to eq("denver,co")
    expect(books_poro.forecast).to be_a Hash 
    expect(books_poro.total_books_found).to be_a Integer
    expect(books_poro.books).to be_a Array
    expect(books_poro.books[0]).to be_a Hash
  end
end