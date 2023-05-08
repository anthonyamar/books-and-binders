class WishlistItemsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_wishlist
  before_action :set_wishlist_item, except: [:new, :create]
  before_action :user_must_own_the_wishlist_item, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @wishlist_item = WishlistItem.new
  end

  def create
    @wishlist_item = WishlistItem.new(wishlist_item_params)

    if @wishlist_item.save
      respond_to do |format|
        format.html { redirect_to(new_wishlist_item_path) }
        flash[:success] = "The item #{@wishlist_item.title} has been added to your '#{@wishlist_item.wishlist.title}' wishlist."
      end
    else
      respond_to do |format|
        format.html { redirect_back(fallback_location: new_wishlist_item_path) }
        @wishlist_item.errors.each do |attr, msg|
          flash[:danger] = "#{attr} -> #{msg}"
        end
      end
    end
  end

  def edit
  end

  def update
    if @wishlist_item.update(wishlist_item_params)
      respond_to do |format|
        format.html { redirect_to(wishlist_item_path(@wishlist_item)) }
        flash[:success] = "The item #{@wishlist_item.title} has been edited."
      end
    else
      respond_to do |format|
        format.html { redirect_back(fallback_location: edit_wishlist_item_path) }
        @wishlist_item.errors.each do |attr, msg|
          flash[:danger] = "#{attr} -> #{msg}"
        end
      end
    end
  end

  def destroy
    if @wishlist_item.destroy
      respond_to do |format|
        format.html { redirect_to(wishlist_items_path) }
        flash[:success] = "The item #{@wishlist_item.title} has been deleted."
      end
    else
      respond_to do |format|
        format.html { redirect_back(fallback_location: wishlist_item_path(@wishlist_item)) }
        @wishlist_item.errors.each do |attr, msg|
          flash[:danger] = "#{attr} -> #{msg}"
        end
      end
    end
  end
  
  private 
  
  def set_wishlist
    @wishlist = Wishlist.find(params[:wishlist_id])
  end
  
  def set_wishlist_item
    @wishlist_item = @wishlist.wishlist_items.find(params[:id])
  end

  def wishlist_params
    params.require(:wishlist_item).permit(:title, :author, :editor, :brief, :target_price, :note, :user_id, :wishlist_id)
  end
  
  def user_must_own_the_wishlist_item
    unless current_user == @wishlist_item.user
      render_404
    end
  end
  
end
