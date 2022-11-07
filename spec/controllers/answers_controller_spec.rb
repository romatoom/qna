require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  let(:user) { create(:user) }

  describe 'GET #new' do
    context 'with authenticated user' do
      before { login(user) }

      before { get :new, params: { question_id: question } }

      it 'renders new view' do
        expect(response).to render_template :new
      end
    end

    context 'with unauthenticated user' do
      before { get :new, params: { question_id: question } }

      it 'redirect to sign in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    let(:create_with_valid_attributes) do
      lambda do
        post :create, params: {
          question_id: question,
          answer: attributes_for(:answer, question_id: question) }
        end
    end

    let(:create_with_invalid_attributes) do
      lambda do
        post :create, params: {
          question_id: question,
          answer: attributes_for(:answer, :invalid, question_id: question)
        }
      end
    end

    context 'with authenticated user' do
      before { login(user) }

      context 'with valid attributes' do
        it 'saves a new answer in the database' do
          expect { create_with_valid_attributes.call }.to change(Answer, :count).by(1)
        end

        it 'redirects to show view' do
          create_with_valid_attributes.call
          expect(response).to redirect_to question_answer_path(assigns(:answer).question, assigns(:answer))
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
    let(:answer) { create(:answer, question:) }

    before { get :show, params: { question_id: question, id: answer } }

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end
