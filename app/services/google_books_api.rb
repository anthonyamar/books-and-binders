class GoogleBooksApi
  
  attr_reader :client, :book
  
  def initialize(isbn:)
    @book = GoogleBooks.search("isbn:#{isbn}").first
  end
  
end