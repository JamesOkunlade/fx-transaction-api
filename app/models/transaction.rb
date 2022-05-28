class Transaction < ApplicationRecord
  # Validations
  validates_presence_of :created_by_id, :input_amount_currency, :input_amount, :output_amount_currency,
    :output_amount, :date_of_transaction

  before_save do
    self.input_amount_currency.downcase!
    self.output_amount_currency.downcase!
  end
end
