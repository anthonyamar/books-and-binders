class WishlistsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_wishlist, except: [:index, :new, :create]
  before_action :user_must_own_the_wishlist, only: [:show, :edit, :update, :destroy]
  
  def index
    @wishlists = current_user.wishlists
  end

  def show
  end

  def new
    @wishlist = Wishlist.new
  end

  def create
    @wishlist = Wishlist.new(wishlist_params)

    if @wishlist.save
      respond_to do |format|
        format.html { redirect_to(new_wishlist_path) }
        flash[:success] = "The wishlist #{@wishlist.title} has been added to your library."
      end
    else
      respond_to do |format|
        format.html { redirect_back(fallback_location: new_wishlist_path) }
        @book.errors.each do |attr, msg|
          flash[:danger] = "#{attr} -> #{msg}"
        end
      end
    end
  end

  def edit
  end

  def update
    if @wishlist.update(wishlist_params)
      respond_to do |format|
        format.html { redirect_to(wishlist_path(@wishlist)) }
        flash[:success] = "The wishlist #{@wishlist.title} has been edited."
      end
    else
      respond_to do |format|
        format.html { redirect_back(fallback_location: edit_wishlist_path) }
        @wishlist.errors.each do |attr, msg|
          flash[:danger] = "#{attr} -> #{msg}"
        end
      end
    end
  end

  def destroy
    if @wishlist.destroy
      respond_to do |format|
        format.html { redirect_to(wishlists_path) }
        flash[:success] = "The wishlist #{@wishlist.title} has been deleted."
      end
    else
      respond_to do |format|
        format.html { redirect_back(fallback_location: wishlist_path(@wishlist)) }
        @book.errors.each do |attr, msg|
          flash[:danger] = "#{attr} -> #{msg}"
        end
      end
    end
  end
  
  private 
  
  def set_wishlist
    @book = Wishlist.find(params[:id])
  end

  def wishlist_params
    params.require(:wishlist).permit(:title, :description)
  end

  def user_must_own_the_wishlist
    unless current_user == @wishlist.user
      render_404
    end
  end
end
