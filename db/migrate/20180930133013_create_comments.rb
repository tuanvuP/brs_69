class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :parent_id
      t.integer :user_id
      t.integer :review_id
      t.text :content

      t.timestamps
    end
  end
end
