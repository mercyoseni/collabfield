require 'ffaker'

def seed_users
  10.times do |num|
    User.create(
      name: "Test #{ num }",
      email: "test#{ num }@test.com",
      password: '123456',
      password_confirmation: '123456'
    )
  end

  p 'Seeding users'
end

def seed_categories
  hobby = [
    'Arts',
    'Crafts',
    'Sports',
    'Sciences',
    'Collecting',
    'Reading',
    'Other'
  ]

  study = [
    'Arts and Humanities',
    'Physical Science and Engineering',
    'Math and Logic',
    'Computer Science',
    'Data Science',
    'Economics and Finance',
    'Business',
    'Social Sciences',
    'Language',
    'Other'
  ]

  team = ['Study', 'Development', 'Arts and Hobby', 'Other']

  hobby.each do |name|
    Category.create(branch: 'hobby', name: name)
  end

  study.each do |name|
    Category.create(branch: 'study', name: name)
  end

  team.each do |name|
    Category.create(branch: 'team', name: name)
  end

  p 'Seeding categories'
end

def seed_posts
  categories = Category.all

  categories.each do |category|
    5.times do
      Post.create(
        title: FFaker::Name.unique.name,
        content: FFaker::Lorem.paragraph,
        user_id: User.pluck(:id).sample,
        category_id: category.id
      )
    end
  end

  p 'Seeding posts'
end

seed_users
seed_categories
seed_posts
