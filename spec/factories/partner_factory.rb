FactoryBot.define do
  factory :partner do
    name   { Faker::Company.name }
    token  { SecureRandom.hex(10) }
  end
end
