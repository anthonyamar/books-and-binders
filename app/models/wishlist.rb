class Wishlist < ApplicationRecord
  
  # ============= constants/enums =================
  # ============= relationships =================
  
  belongs_to :user
  has_many :wishlist_items
  
  # ============= before/after =================
  # ============= validations =================
  # ============= scopes =================
  # ============= class methods =================
  # ============= before/after =================
end