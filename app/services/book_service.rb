class BookService
  def conn
    conn = Faraday.new(url: "https://openlibrary.org")
  end
  
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def search_books(keyword)
    get_url("/search.json?q=#{keyword}")
  end
end