class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
