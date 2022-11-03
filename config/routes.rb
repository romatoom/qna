Rails.application.routes.draw do
  root to: 'questions#index'

  devise_for :users

  resources :questions, only: %i[new create show index] do
    resources :answers, only: %i[new create show]
  end
end
