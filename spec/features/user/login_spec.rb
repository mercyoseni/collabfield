require 'rails_helper'

RSpec.feature 'Login', type: :feature do
  let!(:user) { create(:user) }

  scenario 'user navigates to the login page and succesfully logs in', :js do
    visit root_path

    click_on 'Login'

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password

    click_on 'Log in'

    expect(page).to have_selector('#user-settings')
    expect(page).to have_content(user.name)
  end
end
