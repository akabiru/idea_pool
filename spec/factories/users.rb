FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    avatar_url { Faker::Avatar.image }
    password { 'foobar' }
  end
end
