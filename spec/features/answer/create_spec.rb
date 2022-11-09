require 'rails_helper'

feature 'User can write an answer', %q(
  In order to answer the question
  As an authenticated user
  I'd like to be able to give an answer on the question page
) do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticate user can write an answer' do
    sign_in(user)

    visit new_question_answer_path(question)

    fill_in 'You can answer the question here', with: 'Text text text'
    click_on 'Answer'

    expect(page).to have_content 'Text text text'
  end

  scenario "Unauthenticate user can't write an answer" do
    visit new_question_answer_path(question)

    fill_in 'You can answer the question here', with: 'Text text text'
    click_on 'Answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
