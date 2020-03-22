class Book < ApplicationRecord
  
  # ============= constants/enums =================
  
  enum buying_condition: { brand_new: 0, second_hand: 1, gift: 2, donation: 3 }
  enum actual_condition: { very_good: 0, good: 1, regular: 2, bad: 3, very_bad: 4, unreadable: 5 }
  enum book_type: { physical: 0, numeric: 1, audio: 2 }
  enum binding: { paperback: 0, hardcover: 1, cloth: 2, cardboard: 3, leather: 4, vellum: 5, other: 6 }
  
  
  # ============= relationships =================
  
  belongs_to :user
  
  # ============= before/after =================
  
  before_save :titleize_proper_names
  
  # ============= validations =================
  
  validates :title, :author, 
    :page_count, :buying_condition, :book_type, 
    :category, :actual_condition, :binding, presence: true
  
  validates :title, length: { in: 2..100 }
  validates :author, length: { in: 2..100 }
  validates :editor, length: { in: 2..100 }, allow_nil: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates_date :release_date, on_or_before: :today, allow_nil: true
  validates_date :buyed_at, on_or_before: :today, allow_nil: true
  validates_datetime :started_at, on_or_before: :today, allow_nil: true
  validates_datetime :finished_at, after: :started_at, allow_nil: true
  validates :read, inclusion: { in: [true, false] }
  validates :page_count, numericality: { only_integer: true, greater_than: 0 }
  validates :buying_condition, inclusion: { in: buying_conditions.keys }
  validates :buyed_from, length: { in: 2..100 }, allow_nil: true
  validates :actual_condition, inclusion: { in: actual_conditions.keys }
  validates :book_type, inclusion: { in: book_types.keys }
  validates :binding, inclusion: { in: bindings.keys }
  validates :language, inclusion: { in: I18n.t("languages") }
  validates :category, inclusion: { in: I18n.t("categories") }
  validates :summary, length: { in: 2..10000 }, allow_nil: true
  
  # ============= scopes =================
  
  # ============= class methods =================
  
  # ============= before/after =================
  
  def titleize_proper_names
    self.title = self.title.titleize
    self.author = self.author.titleize
    self.editor = self.editor.titleize if self.editor
    self.buyed_from = self.buyed_from.titleize if self.buyed_from
  end
  
end
