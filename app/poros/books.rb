class Books
  attr_reader :id,
              :destination,
              :forecast,
              :total_books_found,
              :books 
              
  def initialize(destination, forecast, total_books, books)
    @id = nil
    @destination = destination
    @forecast = forecast_hash(forecast)
    @total_books_found = total_books
    @books = format_books(books)
  end

  def forecast_hash(forecast)
    { summary: forecast[0], temperature: "#{forecast[1]} F" }
  end

  def format_books(books)
    books.map do |book|
      book_hash(book)
    end
  end

  def book_hash(book)
    { isbn: book[:isbn], title: book[:title], publisher: book[:publisher]}
  end
end