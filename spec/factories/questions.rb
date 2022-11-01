FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyText" }

    trait :invalid do
      title { nil }
    end

    trait :different_titles do
      sequence :title do |n|
        "MyString#{n}"
      end
    end
  end
end
