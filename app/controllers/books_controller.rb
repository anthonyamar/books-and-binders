class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :user_must_own_the_book, only: [:show, :new, :edit, :update, :destroy]

  def index
    @books = current_user.books
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(band_params)

    if @book.save!
      respond_to do |format|
        format.html { redirect_to(book_path(@book)) }
        flash[:success] = "Le livre #{@book.title} a bien été ajouté à votre bibliothèque."
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

  def edit
  end

  def update
    @book = Book.update(band_params)

    if @book.save!
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

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def band_params
    params.require(:band_form).permit(
      :title, :author, :editor, :price, :release_date, :buyed_at, :started_at, :finished_at, :read, :page_count, :buying_condition, :buyed_from, :condition, :type, :language, :category, :summary,
      :image
    )
  end

  def user_must_own_the_book
    unless current_user == @book.user
      render_404
    end
  end

end
