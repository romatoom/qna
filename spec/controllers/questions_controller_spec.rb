require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe 'GET #new' do
    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:create_with_valid_attributes) do
        -> { post :create, params: { question: attributes_for(:question) } }
      end

      it 'saves a new question in the database' do
        expect { create_with_valid_attributes.call }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        create_with_valid_attributes.call
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      let(:create_with_invalid_attributes) do
        -> { post :create, params: { question: attributes_for(:question, :invalid) } }
      end

      it 'does not save the question' do
        expect { create_with_invalid_attributes.call }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        create_with_invalid_attributes.call
        expect(response).to render_template :new
      end
    end
  end
end
