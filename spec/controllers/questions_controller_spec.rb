require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #new' do
    context 'with authenticated user' do
      before { login(user) }

      before { get :new }

      it 'renders new view' do
        expect(response).to render_template :new
      end
    end

    context 'with unauthenticated user' do
      before { get :new }

      it 'redirect to sign in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    let(:create_with_valid_attributes) do
      -> { post :create, params: { question: attributes_for(:question) } }
    end

    let(:create_with_invalid_attributes) do
      -> { post :create, params: { question: attributes_for(:question, :invalid) } }
    end

    context 'with authenticated user' do
      before { login(user) }

      context 'with valid attributes' do
        it 'saves a new question in the database' do
          expect { create_with_valid_attributes.call }.to change(Question, :count).by(1)
        end

        it 'redirects to new question answer view' do
          create_with_valid_attributes.call
          expect(response).to redirect_to new_question_answer_path(assigns(:question))
        end
      end

      context 'with invalid attributes' do
        it 'does not save the question' do
          expect { create_with_invalid_attributes.call }.to_not change(Question, :count)
        end

        it 're-renders new view' do
          create_with_invalid_attributes.call
          expect(response).to render_template :new
        end
      end
    end

    context 'with unauthenticated user' do
      it 'redirect to sign in page' do
        create_with_valid_attributes.call
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

=begin
  describe 'GET #show' do
    let(:question) { create(:question) }

    before { get :show, params: { id: question } }

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
=end

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
