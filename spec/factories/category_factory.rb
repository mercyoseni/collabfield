FactoryBot.define do
  factory :category do
    name { FFaker::Name.unique.name }
    branch { %w(hobby team study).sample }
  end
end
