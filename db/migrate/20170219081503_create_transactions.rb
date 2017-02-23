class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :txn_type
      t.decimal :amount, precision: 7, scale: 2
      t.string :from_account, foreign_key: true
      t.string :to_account, foreign_key: true
      t.datetime :start_date
      t.datetime :effective_date
      t.string :status

      t.timestamps
    end	
  end
end
