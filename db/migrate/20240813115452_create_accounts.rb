class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :name
      t.decimal :balance

      t.timestamps
    end
  end
end
