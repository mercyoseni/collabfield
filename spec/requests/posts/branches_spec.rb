require 'rails_helper'

include Warden::Test::Helpers

RSpec.describe 'branches', type: :request do
  shared_examples 'render_templates' do
    it 'renders a hobby template' do
      get hobby_posts_path

      expect(response).to render_template(:hobby)
    end

    it 'renders a study template' do
      get study_posts_path

      expect(response).to render_template(:study)
    end

    it 'renders a team template' do
      get team_posts_path

      expect(response).to render_template(:team)
    end
  end

  context 'when user is signed in' do
    let(:user) { create(:user) }
    before(:each) { login_as user }

    it_behaves_like 'render_templates'
  end

  context 'when user is NOT signed in' do
    it_behaves_like 'render_templates'
  end
end
