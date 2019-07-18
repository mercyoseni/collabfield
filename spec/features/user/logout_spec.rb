require 'rails_helper'

RSpec.feature 'Logout', type: :feature do
  let(:user) { create(:user) }

  scenario 'user successfully logs out', :js do
    sign_in user
    visit root_path

    expect(page).not_to have_selector('nav a', text: 'Login')

    click_on user.name
    click_on 'Log out'

    expect(page).to have_selector('nav a', text: 'Login')
  end
end
