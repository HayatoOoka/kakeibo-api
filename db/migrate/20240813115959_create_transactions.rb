class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :account, null: false, foreign_key: true
      t.date :date
      t.decimal :income
      t.decimal :expense
      t.text :description

      t.timestamps
    end
  end
end
