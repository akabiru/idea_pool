FactoryBot.define do
  factory :idea do
    content { Faker::Beer.name }
    impact { Faker::Number.between(0, 10) }
    ease  { Faker::Number.between(0, 10) }
    confidence { Faker::Number.between(0, 10) }
    user nil
  end
end
