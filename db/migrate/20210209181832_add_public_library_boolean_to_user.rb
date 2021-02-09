class AddPublicLibraryBooleanToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :public_profile, :boolean, default: false, null: false
  end
end
