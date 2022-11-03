require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #new' do
    before { get :new, params: { question_id: question } }

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:create_with_valid_attributes) do
        -> { post :create, params: { question_id: question, answer: attributes_for(:answer, question_id: question) } }
      end

      it 'saves a new answer in the database' do
        expect { create_with_valid_attributes.call }.to change(Answer, :count).by(1)
      end

      it 'redirects to show view' do
        create_with_valid_attributes.call
        expect(response).to redirect_to question_answer_path(assigns(:answer).question, assigns(:answer))
      end
    end

    context 'with invalid attributes' do
      let(:create_with_invalid_attributes) do
        -> { post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid, question_id: question) } }
      end

      it 'does not save the question' do
        expect { create_with_invalid_attributes.call }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        create_with_invalid_attributes.call
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #show' do
    let(:answer) { create(:answer, question: question) }

    before { get :show, params: { question_id: question, id: answer } }

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end
