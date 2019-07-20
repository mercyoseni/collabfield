require 'rails_helper'

include Warden::Test::Helpers

RSpec.describe 'new', type: :request do
  context 'when user is signed in' do
    let(:user) { create(:user) }

    it 'renders a new template' do
      login_as user

      get new_post_path

      expect(response).to render_template(:new)
    end
  end

  context 'when user is NOT signed in' do
    it 'redirects to a root path' do
      get new_post_path

      expect(response).to redirect_to(root_path)
    end
  end
end
