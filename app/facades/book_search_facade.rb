class BookSearchFacade
  def book_search(location, quantity)
    service_1 = GeocoderService.new
    service_3 = BookService.new

    lat_long = (service_1.get_coords(location))[:results][0][:locations][0][:latLng]
    coords = format_coords(lat_long)
    forecast_data = forecast_by_coords(coords)
    total_books = service_3.search_books(location)[:numFound]
    books = service_3.search_books(location)[:docs][0..((quantity.to_i) - 1)]
    Books.new(location, forecast_data, total_books, books)
  end

  def format_coords(lat_long)
    "#{lat_long[:lat]},#{lat_long[:lng]}"
  end

  def forecast_by_coords(coords)
    service_2 = WeatherService.new
    response = service_2.get_forecast(coords)
    [response[:current][:condition][:text], response[:current][:temp_f]]
  end
end