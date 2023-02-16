class AddFieldsToBook < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :readable, :boolean, default: true, null: false
    add_column :books, :note, :integer
  end
end
