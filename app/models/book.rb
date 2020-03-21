class Book < ApplicationRecord
  
  # ============= constants/enums =================
  enum buying_condition: { new: 0, second_hand: 1, gift: 2, donation: 3 }
  enum condition: { new: 0, very_good: 1, good: 2, average: 3, bad: 4, very_bad: 5, unreadable: 6 }
  enum type: { physical: 0, numeric: 1, audio: 2 }
  enum binding: { paperback: 0, hardcover: 1, cloth: 2, cardboard: 3, leather: 4, vellum: 5, other: 6 }
  
  
  # ============= relationships =================
  
  belongs_to :user
  
  # ============= before/after =================
  
  # ============= validations =================
  
  validates :title, :author, :price, :read, 
    :page_count, :buying_condition, :type, 
    :category, :condition, presence: true
  
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
  validates :buyed_from, lenght: { in: 2..100 }
  validates :actual_condition, numericality: { only_integer: true, in: conditions.size }
  validates :book_type, numericality: { only_integer: true, in: types.size }
  validates :binding, numericality: { only_integer: true, in: bindings.size }
  validates :language, inclusion: { in: I18n.t("languages") }
  validates :category, inclusion: { in: I18n.t("categories") }
  validates :text, length: { in: 2..10000 }
  
  # ============= scopes =================
  
  # ============= class methods =================
  
  # ============= before/after =================
  
end
