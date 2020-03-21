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
      t.boolean :read
      t.integer :page_count
      t.string :buying_condition
      t.string :buyed_from
      t.string :condition
      t.string :type
      t.string :language
      t.string :category
      t.text :summary
      t.timestamps
    end
  end
end
