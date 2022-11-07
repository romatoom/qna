require 'rails_helper'

feature 'The user can view the question and the answers to it', %q(
  In order to view answers to a question
  As an any user
  I'd like to be able to view the question and its answers
) do

  given(:question) { create(:question) }

  before { create_list(:answer, 3, question: question) }

  scenario 'View the question and its answers' do
    visit question_path(question)

    expect(page).to have_content question.title

    question.answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end
