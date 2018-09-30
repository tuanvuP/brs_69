class CreateBookStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :book_statuses do |t|
      t.string :status
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
