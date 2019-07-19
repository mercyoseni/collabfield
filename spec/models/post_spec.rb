require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Associations' do
    it 'belongs_to user' do
      association = described_class.reflect_on_association(:user).macro
      expect(association).to eq(:belongs_to)
    end

    it 'belongs_to category' do
      association = described_class.reflect_on_association(:category).macro
      expect(association).to eq(:belongs_to)
    end
  end

  describe 'Scopes' do
    it 'default_scope orders by descending created_at' do
      first_post = create(:post)
      second_post = create(:post)

      expect(Post.all).to eq([second_post, first_post])
    end

    it 'by_category scope gets posts by particular category' do
      category = create(:category)
      create(:post, category: category)
      create_list(:post, 2)
      posts = Post.by_category(category.branch, category.name)

      expect(posts.count).to eq(1)
      expect(posts.first.category.name).to eq(category.name)
    end

    it 'by_branch scope gets posts by particular branch' do
      category = create(:category, branch: 'hobby')
      team_category = create(:category, branch: 'team')

      create(:post, category: category)
      create_list(:post, 2, category: team_category)

      posts = Post.by_branch(category.branch)

      expect(posts.count).to eq(1)
      expect(posts.first.category.branch).to eq(category.branch)
    end

    it 'search finds a matching post' do
      post = create(:post, title: 'awesome title', content: 'great content ' * 5)
      create_list(:post, 2, title: ('a'..'c' * 2).to_a.shuffle.join)

      expect(Post.search('awesome').count).to eq(1)
      expect(Post.search('awesome').first).to eq(post)
      expect(Post.search('great').count).to eq(1)
      expect(Post.search('great').first).to eq(post)
    end
  end
end
