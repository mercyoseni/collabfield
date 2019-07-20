FactoryBot.define do
  factory :category do
    name { FFaker::Name.unique.name }
    branch 'team'
  end
end
