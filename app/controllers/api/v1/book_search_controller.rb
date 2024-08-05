class Api::V1::BookSearchController < ApplicationController
  def index
    facade = BookSearchFacade.new
    books_poro = facade.book_search(params[:location], params[:quantity])
    render json: BooksSerializer.new(books_poro)
  end
end
