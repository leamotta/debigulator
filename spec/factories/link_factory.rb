FactoryBot.define do
  factory :link do
    code        { Faker::Lorem.characters(number: 7) }
    destination { Faker::Internet.url }
  end
end
