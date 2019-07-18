FactoryBot.define do
  factory :category do
    name FFaker::Name.unique.name
    sequence(:branch) { |n| "branch #{ n }" }
  end
end
