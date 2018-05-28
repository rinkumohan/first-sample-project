require 'faker'

FactoryBot.define do
  factory :deposite_account do |f|
    f.transaction_type { "Credit" }
    f.last_transaction_amount {Faker::Number.between(1, 10000)}
    f.available_balance { Faker::Number..between(1, 50000) }
  end
end
