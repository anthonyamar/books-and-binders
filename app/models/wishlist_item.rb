class WishlistItem < ApplicationRecord
  
  # ============= constants/enums =================
  # ============= relationships =================
  
  belongs_to :user
  belongs_to :wishlist
  
  # ============= before/after =================
  # ============= validations =================
  # ============= scopes =================
  # ============= class methods =================
  # ============= before/after =================
end
