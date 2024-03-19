Rails.application.routes.draw do

  root 'surveys#index'
  devise_for :users
  resources :surveys do
    member do
      get 'responses', to: 'surveys#responses'
    end
    resources :responses
  end
end
