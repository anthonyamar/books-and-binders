class CreateWishlistItems < ActiveRecord::Migration[6.1]
  def change
    create_table :wishlist_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :wishlist, null: false, foreign_key: true
      
      t.string :title
      t.string :author
      t.string :editor
      t.string :brief
      t.decimal :target_price
      t.integer :priority

      t.timestamps
    end
  end
end
