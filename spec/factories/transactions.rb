FactoryBot.define do
  factory :transaction do
    created_by_id { Faker::Number.number(digits: 10) }
    input_amount_currency { 'USD' }
    input_amount { 1000 }
    output_amount_currency { 'NGN' }
    output_amount { 570000 }
    date_of_transaction { rand(1.week).seconds.ago }
  end
end
