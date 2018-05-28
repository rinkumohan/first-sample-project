class CreateDepositeAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :deposite_accounts do |t|
      t.string :transaction_type
      t.integer :last_transaction_amount
      t.integer :available_balance
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
