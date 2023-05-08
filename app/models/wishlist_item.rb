class WishlistItem < ApplicationRecord
  
  # ============= constants/enums =================
  # ============= relationships =================
  
  belongs_to :user
  belongs_to :wishlist
  
  # ============= before/after =================
  
  # ============= validations =================
  validates :title, length: { in: 2..100 }, presence: true
  validates :author, length: { in: 2..100 }, presence: true
  validates :editor, length: { in: 2..100 }, allow_nil: true
  validates :target_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :priority, numericality: { in: [1..5] }, presence: true
  
  # ============= scopes =================
  # ============= class methods =================
  # ============= before/after =================
end
