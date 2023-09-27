FactoryBot.define do
  factory :url do
    original  { Faker::Internet.url }
    short     { SecureRandom.alphanumeric(5) }
  end
end
