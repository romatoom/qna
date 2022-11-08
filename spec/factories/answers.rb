FactoryBot.define do
  factory :answer do
    question { nil }
    author { nil }
    body { "MyText" }

    trait :invalid do
      body { nil }
    end
  end
end
