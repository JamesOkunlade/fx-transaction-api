# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
50.times do
  transaction = Transaction.create(created_by_id: Faker::Number.number(digits: 4), input_amount_currency: 'USD',
    input_amount_cents: 1000_00, output_amount_currency: 'NGN', output_amount_cents: 570000_00, date_of_transaction: rand(1.week).seconds.ago)
end