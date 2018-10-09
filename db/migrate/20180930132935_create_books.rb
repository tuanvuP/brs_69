class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :author
      t.float :rates
      t.integer :category_id
      t.string :file
      t.string :book_img_file_name
      t.integer :book_img_file_size
      t.string :book_img_content_type
      t.datetime :book_img_updated_at

      t.timestamps
    end
  end
end
