FactoryBot.define do
  factory :post do
    title FFaker::Book.title
    content FFaker::Lorem.paragraph
    user
    category
  end
end
