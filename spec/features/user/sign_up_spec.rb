require 'rails_helper'

RSpec.feature 'Sign up', type: :feature do
  let(:user) { build(:user) }

  scenario 'user navigates to sign up page and successfully signs up', :js do
    visit root_path

    click_on 'Signup'

    fill_in 'user[name]', with: user.name
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password_confirmation

    click_on 'Sign up'

    expect(page).to have_selector('#user-settings')
    expect(page).to have_content(user.name)
  end
end
