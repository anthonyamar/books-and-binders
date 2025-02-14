class BooksController < ApplicationController

  before_action :authenticate_user!, except: [:public_profile]
  before_action :set_book, except: [:index, :public_profile, :new, :create]
  before_action :user_must_own_the_book, only: [:show, :edit, :update, :destroy, :download_md_note, :start_reading, :finish_reading]

  def index
    @books = current_user.books
  end

  def show
#    render component: 'Book', props: { book: @book }
    @google_book = GoogleBooksApi.new(isbn: @book.isbn).book
    @raw_markdown = BookToMarkdown.new(@book).perform
  end
  
  def public_profile
    @user = User.find_by(username: params[:username])
    @facade = BookFacade.new(@user)
    @books = @user.books
    render layout: "public_profile"
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      respond_to do |format|
        format.html { redirect_to(new_book_path) }
        flash[:success] = "Le livre #{@book.title} a bien été ajouté à votre bibliothèque."
      end
    else
      respond_to do |format|
        format.html { redirect_back(fallback_location: new_book_path) }
        @book.errors.each do |attr, msg|
          flash[:danger] = "#{attr} -> #{msg}"
        end
      end
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      respond_to do |format|
        format.html { redirect_to(book_path(@book)) }
        flash[:success] = "Le livre #{@book.title} a bien été édité."
      end
    else
      respond_to do |format|
        format.html { redirect_back(fallback_location: edit_book_path) }
        @book.errors.each do |attr, msg|
          flash[:danger] = "#{attr} -> #{msg}"
        end
      end
    end
  end

  def destroy
    if @book.destroy
      respond_to do |format|
        format.html { redirect_to(books_path) }
        flash[:success] = "Le livre #{@book.title} a bien été supprimé de votre bibliothèque."
      end
    else
      respond_to do |format|
        format.html { redirect_back(fallback_location: book_path(@book)) }
        @book.errors.each do |attr, msg|
          flash[:danger] = "#{attr} -> #{msg}"
        end
      end
    end
  end
  
  def download_md_note
    send_data BookToMarkdown.new(@book).perform, filename: "#{@book.title} - #{@book.author}.md"
  end
  
  def start_reading
    if @book.update(started_at: DateTime.now)
      respond_to do |format|
        format.html { redirect_to(book_path(@book)) }
        flash[:success] = "Bonne lecture !"
      end
    else
      respond_to do |format|
        format.html { redirect_to(book_path(@book)) }
        @book.errors.each do |attr, msg|
          flash[:danger] = "#{attr} -> #{msg}"
        end
      end
    end
  end
  
  def finish_reading
    if @book.update(finished_at: DateTime.now)
      respond_to do |format|
        format.html { redirect_to(book_path(@book)) }
        flash[:success] = "Félicitations !"
      end
    else
      respond_to do |format|
        format.html { redirect_to(book_path(@book)) }
        @book.errors.each do |attr, msg|
          flash[:danger] = "#{attr} -> #{msg}"
        end
      end
    end
  end
  
  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(
      :title, :author, :editor, :price, :release_date, :buyed_at, :started_at, :finished_at, :read, :page_count, :buying_condition, :buyed_from, :actual_condition, :book_type, :binding, :language, :category, :reviewed, :user_id, :image, :isbn, :weight_in_grams, :started_at, :finished_at, :readable, :note
    )
  end

  def user_must_own_the_book
    unless current_user == @book.user
      render_404
    end
  end

end
