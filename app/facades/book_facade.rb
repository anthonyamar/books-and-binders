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
  
  def total_pages
    books.sum(&:page_count)
  end
  
  def total_read_pages
    books.read.sum(&:page_count)
  end
  
  def total_unread_pages
    books.unread.sum(&:page_count)
  end
  
  def read_percentage
    (total_read_pages * 100.0 / total_pages).round(2)
  end
  
  # WEIGHT
  
  def total_weight(unit: :kg)
    weight = books.reject { |b| b.weight_in_grams.nil? }.sum(&:weight_in_grams)
    if unit == :grams
      weight
    elsif unit == :kg
      weigh * 100
    end
  end
  
  # MONEY
  
  def total_spent
    books.reject { |b| b.price.nil? }.sum(&:price)
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
    books.order(:weight_in_grams).first(take)
  end
  
  def heavier_book(take: 1)
    books.order(:weight_in_grams).last(take)
  end
  
  def most_expansive_book(take: 1)
    books.order(:price).last(take)
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