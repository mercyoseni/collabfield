require 'rails_helper'

RSpec.describe PostsHelper, type: :helper do
  describe '#create_new_post_partial_path' do
    context 'when user is signed in' do
      before do
        allow(helper).to receive(:user_signed_in?).and_return(true)
      end

      it "returns a signed_in partial's path" do
        expect(helper.create_new_post_partial_path). to eq(
          'posts/branch/create_new_post/signed_in'
        )
      end
    end

    context 'when user is NOT signed in' do
      before do
        allow(helper).to receive(:user_signed_in?).and_return(false)
      end

      it "returns a not_signed_in partial's path" do
        expect(helper.create_new_post_partial_path). to eq(
          'posts/branch/create_new_post/not_signed_in'
        )
      end
    end
  end

  describe '#all_categories_button_partial_path' do
    context 'when category params is empty' do
      it "returns an all_selected partial's path" do
        controller.params[:category] = ''

        expect(helper.all_categories_button_partial_path).to eq(
          'posts/branch/categories/all_selected'
        )
      end
    end

    context 'when category params is NOT empty' do
      it "returns an all_not_selected partial's path" do
        controller.params[:category] = 'category'

        expect(helper.all_categories_button_partial_path).to eq(
          'posts/branch/categories/all_not_selected'
        )
      end
    end
  end

  describe '#no_posts_partial_path' do
    context 'when there is post' do
      it "returns an empty partial's path" do
        assign(:posts, [1])

        expect(helper.no_posts_partial_path).to eq(
          'shared/empty_partial'
        )
      end
    end

    context 'when there is NO post' do
      it "returns a no_posts partial's path" do
        assign(:posts, [])

        expect(helper.no_posts_partial_path).to eq(
          'posts/branch/no_posts'
        )
      end
    end
  end
end
