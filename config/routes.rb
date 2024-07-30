Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
  root "events#index"
  resources :events do
    resources :comments, only: %i[create destroy edit update]
    resources :subscriptions, only: %i[create destroy]
    resources :photographs, only: %i[create destroy show index]
  end
  resources :users, only: %i[show]
end
