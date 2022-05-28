class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :created_by_id
      t.string :input_amount_currency
      t.decimal :input_amount, precision: 10, scale: 2
      t.string :output_amount_currency
      t.decimal :output_amount, precision: 10, scale: 2
      t.datetime :date_of_transaction

      t.timestamps
    end
  end
end
