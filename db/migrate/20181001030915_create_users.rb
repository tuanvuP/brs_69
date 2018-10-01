class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :book_id
      t.string :password_digest
      t.string :reset_digest
      t.string :remenber_digest
      t.boolean :activated
      t.string :activation_digest
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
