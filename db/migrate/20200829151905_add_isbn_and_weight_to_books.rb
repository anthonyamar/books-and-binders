class AddIsbnAndWeightToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :isbn, :string
    add_column :books, :weight_in_grams, :integer
  end
end
