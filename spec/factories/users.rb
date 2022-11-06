FactoryBot.define do
  factory :user do
    email { "user@test.com" }
    password { "12345678" }

    trait :wrong_email do
      email { "wrong_user@test.com" }
    end
  end
end
