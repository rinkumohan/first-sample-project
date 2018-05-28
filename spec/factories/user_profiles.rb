require 'faker'

FactoryBot.define do
  factory :user_profile do |f|
    f.name { Faker::Name.name }
    f.sex { Faker::Name.name }
    f.address { Faker::Address.city }
    f.phone_number { Faker::PhoneNumber.cell_phone }
    f.account_type { 1 }
    f.account_number {Faker::Number.between(1, 10)}
    f.user_id { Faker::Number.digit }
  end
end
