Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  config = Rails.application.config.baukis2

  constraints host: config[:staff][:host] do
    namespace :staff, path:config[:staff][:path] do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      resources :session, only: [ :create, :destroy ]
      resources :account, except: [ :new, :create, :destroy ]
    end
  end

  constraints host: config[:admin][:host] do
    namespace :admin, path:config[:admin][:path] do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      resources :session, only: [ :create, :destroy ]
      resources :staff_members
    end
  end

  constraints host: config[:customer][:host] do
    namespace :customer, path:config[:customer][:path] do
      root 'top#index'
    end
  end
end
