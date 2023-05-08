class AddIsbnToWishlistItem < ActiveRecord::Migration[6.1]
  def change
    add_column :wishlist_items, :isbn, :string
  end
end
