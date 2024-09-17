class RemoveBalanceFromAccounts < ActiveRecord::Migration[6.1]
  def change
    remove_column :accounts, :balance, :decimal
  end
end
