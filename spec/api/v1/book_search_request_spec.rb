require "rails_helper"

describe "book-search" do
  it "returns a properly formatted hash of weather and book data for a given location", :vcr do
    get "/api/v1/book-search?location=denver,co&quantity=5"

    expect(response).to be_successful

    data = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(data).to be_a Hash
    expect(data[:id]).to eq(nil)
    expect(data[:type]).to eq("books")
    expect(data[:attributes]).to have_key :destination
    expect(data[:attributes]).to have_key :forecast
    expect(data[:attributes]).to have_key :total_books_found
    expect(data[:attributes]).to have_key :books

    expect(data[:attributes][:destination]).to eq("denver,co")

    expect(data[:attributes][:forecast]).to be_a Hash
    expect(data[:attributes][:forecast][:summary]).to be_a String
    expect(data[:attributes][:forecast][:temperature]).to be_a String

    expect(data[:attributes][:total_books_found]).to be_a Integer

    expect(data[:attributes][:books]).to be_a Array
    expect(data[:attributes][:books][0]).to be_a Hash
    all_books = data[:attributes][:books]
    expect(all_books.count).to eq(5)
    first_book = data[:attributes][:books][0]
    expect(first_book[:isbn]).to be_a Array
    expect(first_book[:title]).to be_a String
    expect(first_book[:publisher]).to be_a Array
  end
end