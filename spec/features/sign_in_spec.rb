require 'rails_helper'

feature 'User can sign in', %q(
  In order to ask questions
  As an unauthenticated user
  I'd like to be able to sign in
) do
  scenario 'Registered user tries to sign in' do
    User.create!(email: 'user@test.com', password: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '12345678'

    save_and_open_page
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Unregistered user tries to sign in'
end
