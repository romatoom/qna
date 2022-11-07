require 'rails_helper'

feature 'The user can view the list of questions', %q(
  In order to select a question
  As a any user
  I would like to be able to view the list of questions
) do

  scenario 'Any user can view the list of questions' do
    create_list(:question, 3)

    visit questions_path

    Question.all.each do |question|
      expect(page).to have_content question.title
    end
  end
end
