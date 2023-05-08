class Wishlist < ApplicationRecord
  
  # ============= constants/enums =================
  # ============= relationships =================
  
  belongs_to :user
  has_many :wishlist_items
  
  # ============= before/after =================
  
  validates :title, length: { in: 2..100 }, presence: true
  
  # ============= validations =================
  # ============= scopes =================
  # ============= class methods =================
  # ============= before/after =================
end
