class BookFacade
  
  attr_reader :books
  
  def initialize(user)
    @books = user.books
  end

  # TOTAL 
  
  def books_size
    books.size
  end
  
  # READ AND PAGES
  def total_readable_books
    readable_books.size
  end
  
  def total_pages
    books.sum(&:page_count)
  end
  
  def average_pages
    books.sum(&:page_count) / books.size
  end
  
  def total_readable_pages
    readable_books.sum(&:page_count)
  end
  
  def total_read_pages
    total_read.sum(&:page_count)
  end
  
  def total_read
    readable_books.read
  end
  
  def total_unread
    readable_books.unread
  end
  
  def read_percentage
    (total_read.size * 100.0 / total_readable_books).round(2)
  end
  
  # WEIGHT
  
  def books_with_weight
    books.where.not(weight_in_grams: nil)
  end
  def total_weight(unit: :kg)
    sum = books_with_weight.sum(&:weight_in_grams)
    unit == :grams ? sum : sum / 1000
  end
  
  def total_read_weight(unit: :kg)
    sum = books_with_weight.read.sum(&:weight_in_grams)
    unit == :grams ? sum : sum / 1000
  end
  
  def average_weight
    total_weight(unit: :grams) / books.size
  end
  
  # MONEY
  
  def books_with_price
    books.where.not(price: nil)
  end
  
  def total_spent
    books_with_price.sum(&:price)
  end
  
  def average_spent
    books_with_price.sum(&:price) / books_with_price.size
  end
  
  # FIRST/LAST

  def last_book_added(take: 1)
    books.last(take)
  end
  
  def shortest_book(take: 1)
    books.order(:page_count).first(take)
  end
  
  def longest_book(take: 1)
    books.order(:page_count).last(take)
  end
  
  def lighter_book(take: 1)
    books_with_weight.order(:weight_in_grams).first(take)
  end
  
  def heavier_book(take: 1)
    books_with_weight.order(:weight_in_grams).last(take)
  end
  
  def most_expansive_book(take: 1)
    books_with_price.order(:price).last(take)
  end
  
  def readable_books
    books.readable
  end
  
  # REPARTITION
  
  def category_repartition
    books.group_by(&:category).map { |k, v| [k, v.size] }.to_h
  end
  
  def language_repartition
    books.group_by(&:language).map { |k, v| [k, v.size] }.to_h
  end
  
  def book_type_repartition
    books.group_by(&:book_type).map { |k, v| [k, v.size] }.to_h
  end
  
  def binding_repartition
    books.group_by(&:binding).map { |k, v| [k, v.size] }.to_h
  end
  
end