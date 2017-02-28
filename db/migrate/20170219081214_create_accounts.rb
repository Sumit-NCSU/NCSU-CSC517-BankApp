class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :status
      t.decimal :balance, precision: 7, scale: 2, :default => 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
