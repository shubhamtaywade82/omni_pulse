# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root 'chats#index'

  resources :conversations, only: %i[show create] do
    resources :chats, only: :create
  end

  namespace :api do
    namespace :v1 do
      get 'dhan/holdings'
      get 'dhan/place_order'
      post 'chat',     to: 'chat#create'
      get  'holdings', to: 'dhan#holdings'
      post 'orders',   to: 'dhan#place_order'
    end
  end
end
