class UpdateMarkdownNote
  
  attr_reader :path, :book
  
  PATH = "public/notes/to_update/"
  UPDATED_PATH = "public/notes/updated/"
  NO_MATCHES = []
  
  def perform
    @path = Rails.root.join("public/notes/La Richesse Des Nations II - Adam Smith.md")
    binding.pry
  end
  
  def get_review_text(filename)
    file = File.open(PATH + filename)
    file.read[/%%start:review%%(.*?)%%end:review%%/m, 1]
  end
  
  def title_by_filename(filename)
    filename.split(' - ').first
  end
  
  def id_by_md_parse(filename)
    file = File.open(PATH + filename)
    file.read[/%%id:(.*?)%%/m, 1].to_i
  end
  
  def get_book(filename)
    Book.where('title = ? OR id = ?', title_by_filename(filename), id_by_md_parse(filename)).first
  end
  
  def raw_markdown(book, review)
    BookToMarkdown.new(book).perform(review)
  end
  
  def update_notes
    Dir.foreach(PATH) do |filename|
      next unless filename.last(3) == ".md"
      book = get_book(filename)
      if book.nil?
        NO_MATCHES << filename
        next
      else
        File.open(UPDATED_PATH + filename, "w") { |file| file.write(raw_markdown(book, get_review_text(filename))) }
      end
    end
    puts "============================================="
    puts "#{NO_MATCHES.size} files to update by hand :"
    puts NO_MATCHES
    puts "============================================="
  end
  
end