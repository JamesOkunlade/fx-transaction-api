require 'rails_helper'

RSpec.describe Transaction, type: :model do
  # Validation tests
  it { should validate_presence_of(:created_by_id) }
  it { should validate_presence_of(:input_amount_currency) }
  it { should validate_presence_of(:input_amount) }
  it { should validate_presence_of(:output_amount_currency) }
  it { should validate_presence_of(:output_amount) }
  it { should validate_presence_of(:date_of_transaction) }
end
