Rails.application.routes.draw do
  root to: 'pages#index'

  devise_for :users

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end
end
