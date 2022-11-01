require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe 'GET #new' do
    before { get :new }

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

  describe 'GET #show' do
    let(:question) { create(:question) }

    before { get :show, params: { id: question } }

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #index' do
    let(:questions) { create_list(:question, 3) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to eq questions
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end
end
