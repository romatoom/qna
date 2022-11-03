Rails.application.routes.draw do
  root 'questions#index'

  resources :questions, only: %i(new create show index) do
    resources :answers, only: %i(new create show)
  end
end
