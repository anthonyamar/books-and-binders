class WishlistItem < ApplicationRecord
  
  # ============= constants/enums =================
  # ============= relationships =================
  
  belongs_to :user
  belongs_to :wishlist
  
  # ============= before/after =================
  
  # ============= validations =================
  validates :title, length: { in: 2..100 }, presence: true
  validates :author, length: { in: 2..100 }, presence: true
  validates :target_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :priority, numericality: { in: [1..5] }, presence: true
  validates :isbn, format: { with: /(?=(?:\D*\d){10}(?:(?:\D*\d){3})?$)/, message: "ISBN must be 10 or 13 numbers long and start with 978 or 979" }, allow_blank: true
  
  # ============= scopes =================
  # ============= class methods =================
  # ============= before/after =================
end
