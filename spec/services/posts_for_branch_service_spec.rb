require 'rails_helper'
require './app/services/posts_for_branch_service.rb'

describe PostsForBranchService do
  describe '#run' do
    let!(:not_included_posts) { create_list(:post, 2) }
    let!(:category) { create(:category, branch: 'hobby', name: 'arts') }
    let(:post) do
      create(
        :post,
        title: 'a very fun post',
        category_id: category.id
      )
    end

    it 'returns posts filtered by a branch' do
      included_posts = create_list(:post, 2, category_id: category.id)

      expect(PostsForBranchService.new({ branch: 'hobby' }).run)
        .to match_array(included_posts)
    end

    it 'returns posts filtered by a branch and a search input' do
      included_post = [] << post

      expect(PostsForBranchService.new({ branch: 'hobby', search: 'fun' }).run)
        .to eq(included_post)
    end

    it 'returns posts filtered by a category name' do
      included_post = [] << post

      expect(
        PostsForBranchService.new({ branch: 'hobby', category: 'arts' }).run
      ).to eq(included_post)
    end

    it 'returns posts filtered by a category name and a search input' do
      included_post = [] << post

      expect(PostsForBranchService.new({
        name: 'arts',
        search: 'fun',
        branch: 'hobby'
      }).run).to eq(included_post)
    end
  end
end
