class Book < ApplicationRecord
  
  # ============= constants/enums =================
  enum buying_condition: { brand_new: 0, second_hand: 1, gift: 2, donation: 3 }
  enum actual_condition: { very_good: 0, good: 1, regular: 2, bad: 3, very_bad: 4, unreadable: 5 }
  enum book_type: { physical: 0, numeric: 1, audio: 2 }
  enum binding: { paperback: 0, hardcover: 1, cloth: 2, cardboard: 3, leather: 4, vellum: 5, other: 6 }
  
  
  # ============= relationships =================
  
  belongs_to :user
  
  # ============= before/after =================
  
  # ============= validations =================
  
  validates :title, :author, :price, 
    :page_count, :buying_condition, :book_type, 
    :category, :actual_condition, :binding, presence: true
  
  validates :title, length: { in: 2..100 }
  validates :author, length: { in: 2..100 }
  validates :editor, length: { in: 2..100 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates_date :release_date, on_or_before: :today
  validates_date :buyed_at, on_or_before: :today
  validates_datetime :started_at, on_or_before: :today
  validates_datetime :finished_at, on_or_before: :today
  validates :read, inclusion: { in: [true, false] }
  validates :page_count, numericality: { only_integer: true, greater_than: 0 }
  validates :buying_condition, numericality: { only_integer: true, in: buying_conditions.size }
  validates :buyed_from, length: { in: 2..100 }
  validates :actual_condition, numericality: { only_integer: true, in: actual_conditions.size }
  validates :book_type, numericality: { only_integer: true, in: book_types.size }
  validates :binding, numericality: { only_integer: true, in: bindings.size }
  validates :language, inclusion: { in: I18n.t("languages") }
  validates :category, inclusion: { in: I18n.t("categories") }
  validates :summary, length: { in: 2..10000 }
  
  # ============= scopes =================
  
  # ============= class methods =================
  
  # ============= before/after =================
  
end