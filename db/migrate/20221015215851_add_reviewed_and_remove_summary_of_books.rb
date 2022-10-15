class AddReviewedAndRemoveSummaryOfBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :reviewed, :boolean, default: false, null: false
    remove_column :books, :summary
  end
end
