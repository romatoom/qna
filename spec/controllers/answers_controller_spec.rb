require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }

  let(:question) { create(:question, author: user) }

  let(:answer) { create(:answer, question: question, author: user) }

=begin
  describe 'GET #new' do
    context 'with authenticated user' do
      before { login(user) }

      before { get :new, params: { question_id: question, author_id: user } }

      it 'renders new view' do
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with unauthenticated user' do
      before { get :new, params: { question_id: question, author_id: user } }

      it 'redirect to sign in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
=end

  describe 'POST #create' do
    let(:create_with_valid_attributes) do
      lambda do
        post :create, params: {
          question_id: question,
          author_id: user.id,
          answer: attributes_for(:answer, question_id: question, author_id: user) }
        end
    end

    let(:create_with_invalid_attributes) do
      lambda do
        post :create, params: {
          question_id: question,
          author_id: user.id,
          answer: attributes_for(:answer, :invalid, question_id: question, author_id: user)
        }
      end
    end

    context 'with authenticated user' do
      before { login(user) }

      context 'with valid attributes' do
        it 'saves a new answer in the database' do
          expect { create_with_valid_attributes.call }.to change(Answer, :count).by(1)
        end

        it 'redirects to question page' do
          create_with_valid_attributes.call
          expect(response).to redirect_to new_question_answer_path(question)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the question' do
          expect { create_with_invalid_attributes.call }.to_not change(Answer, :count)
        end

        it 're-renders new view' do
          create_with_invalid_attributes.call
          expect(response).to render_template :new
        end
      end
    end

    context 'with unauthenticated user' do
      before { create_with_valid_attributes.call }

      it 'redirect to sign in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #show' do
    before { get :show, params: { question_id: question, id: answer } }

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'DELETE #destroy' do
    before { create_list(:answer, 3, question: question, author: user) }
    let!(:answer) { create(:answer, question: question, author: user) }

    let(:delete_answer) do
      lambda { delete :destroy, params: { question_id: question.id, id: answer.id } }
    end

    context 'with authenticated user' do
      before { login(user) }

      it 'number of answers decreased by 1' do
        expect { delete_answer.call }.to change(Answer, :count).by(-1)
      end

      it 'redirect to question show' do
        delete_answer.call
        expect(response).to redirect_to new_question_answer_path(question)
      end
    end

    it 'with unauthenticated user' do
      expect { delete_answer.call }.to_not change(Answer, :count)
    end
  end
end
