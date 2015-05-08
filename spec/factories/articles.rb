FactoryGirl.define do
  factory :article do
    name { Faker::Name.name }
  end
end
