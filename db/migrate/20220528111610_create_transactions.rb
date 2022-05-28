class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :created_by_id
      t.string :input_amount_currency
      t.bigint :input_amount_cents
      t.string :output_amount_currency
      t.bigint :output_amount_cents
      t.datetime :date_of_transaction

      t.timestamps
    end
  end
end
