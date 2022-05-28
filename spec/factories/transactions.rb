FactoryBot.define do
  factory :transaction do
    created_by_id { Faker::Number.number(digits: 4) }
    input_amount_currency { 'USD' }
    input_amount_cents { 1000_00 }
    output_amount_currency { 'NGN' }
    output_amount_cents { 570000_00 }
    date_of_transaction { rand(1.week).seconds.ago }
  end
end
