class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.integer :followed_id
      t.integer :follower_id
      t.integer :activated
      t.datetime :activated_at

      t.timestamps
    end
  end
end
