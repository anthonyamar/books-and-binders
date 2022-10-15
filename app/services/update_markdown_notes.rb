class UpdateMarkdownNotes
  
  attr_reader :path, :book
  
  PATH = "public/notes/to_update/"
  UPDATED_PATH = "public/notes/updated/"
  
  def perform
    no_matches = []
    Dir.foreach(PATH) do |filename|
      next unless filename.last(3) == ".md"
      book = get_book(filename)
      if book.nil?
        no_matches << filename
        next
      else
        File.open(UPDATED_PATH + filename, "w") { |file| file.write(raw_markdown(book, get_review_text(filename))) }
      end
    end
    puts "============================================="
    puts "#{no_matches.size} files to update by hand :"
    puts no_matches
    puts "============================================="
  end
  
  private
  
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
    Book.where('LOWER(title) = ? OR id = ?', title_by_filename(filename).downcase, id_by_md_parse(filename)).first
  end
  
  def raw_markdown(book, review)
    BookToMarkdown.new(book).perform(review)
  end
  
end