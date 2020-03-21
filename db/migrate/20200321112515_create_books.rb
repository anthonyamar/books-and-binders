class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :editor
      t.decimal :price
      t.date :release_date
      t.date :buyed_at
      t.datetime :started_at
      t.datetime :finished_at
      t.boolean :read, default: false
      t.integer :page_count, null: false
      t.integer :buying_condition, default: 0, null: false
      t.string :buyed_from
      t.integer :actual_condition, default: 0, null: false
      t.integer :book_type, default: 0, null: false
      t.integer :binding, default: 0, null: false
      t.string :language
      t.string :category
      t.text :summary
      t.timestamps
    end
  end
end
