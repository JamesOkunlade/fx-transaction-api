class Transaction < ApplicationRecord
  # Validations
  validates_presence_of :created_by_id, :input_amount_currency, :input_amount_cents, :output_amount_currency,
    :output_amount_cents, :date_of_transaction

  before_save do
    self.input_amount_currency.downcase!
    self.output_amount_currency.downcase!
  end

  after_commit :flush_cache

  def self.cached_all
    Rails.cache.fetch([name, 'all']) do
      self.all.to_a
    end
  end

  def flush_cache
    Rails.cache.delete([self.class.name, 'all'])
  end
end
