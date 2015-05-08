FactoryGirl.define do
  factory :post do
    author { Faker::Name.name }
    body { Faker::Lorem.sentence }
  end
end
