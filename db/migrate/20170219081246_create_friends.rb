class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
	  t.integer :friend1_id, foreign_key: true
      t.integer :friend2_id, foreign_key: true
      t.timestamps
    end
  end
end
