require 'rails_helper'

RSpec.feature 'Create a new post', type: :feature do
  let(:user) { create(:user) }

  before { sign_in user }

  shared_examples 'user creates a new post' do |branch|
    scenario 'successfully' do
      create(:category, name: 'category', branch: branch)

      visit send("#{ branch }_posts_path")

      click_on 'Create a new post'

      fill_in 'post[title]', with: 'a' * 20
      fill_in 'post[content]', with: 'a' * 20

      click_on 'Create a post'

      expect(page).to have_selector('h3', text: 'a' * 20)
      expect(page).to have_content("Posted by #{ user.name }")
    end

    # If the front-end validations is disabled in dev tools
    # TODO: Only passes in driver mode at the moment, find a fix
    scenario 'NOT successful', :js, driver: :selenium do
      create(:category, name: 'category', branch: branch)

      visit send("#{ branch }_posts_path")

      click_on 'Create a new post'

      # Remove required attribute on title and content
      page.execute_script("$('#post_title').removeAttr('required')")
      page.execute_script("$('#post_content').removeAttr('required')")

      click_on 'Create a post'

      expect(page).to have_content('The form contains 4 errors.')
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content('Title is too short (minimum is 5 characters)')
      expect(page).to have_content("Content can't be blank")
      expect(page).to have_content('Content is too short (minimum is 20 characters)')
    end
  end

  include_examples 'user creates a new post', 'hobby'
  include_examples 'user creates a new post', 'study'
  include_examples 'user creates a new post', 'team'
end
