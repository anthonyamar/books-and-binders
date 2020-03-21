class AddUserReferencesToBooks < ActiveRecord::Migration[6.0]
  def change
    add_reference :books, :user
  end
end
