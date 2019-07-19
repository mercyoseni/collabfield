require 'rails_helper'

RSpec.feature 'Visit single post', type: :feature do
  let!(:post) { create(:post) }

  scenario 'User goes to a single post from the home page', :js do
    visit root_path

    page.find('.single-post-card').click

    expect(page).to have_content(post.content)

    click_on "I'm interested"

    expect(page).to have_content("Posted by #{ post.user.name }")
    expect(page).to have_content(post.title)
    expect(page).to have_content(post.content)
  end
end
