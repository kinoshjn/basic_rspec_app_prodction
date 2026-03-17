FactoryBot.define do
  factory :task do
    title { "Test Task" }
    content { "Test Content" }
    status { :todo }
    association :user
  end
end
