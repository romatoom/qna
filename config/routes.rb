Rails.application.routes.draw do
  root to: 'questions#index'

  devise_for :users

  resources :questions, only: %i[new create index destroy] do
    resources :answers, only: %i[new create show destroy]
  end
end
