Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  config = Rails.application.config.baukis2

  constraints host: config[:staff][:host] do
    namespace :staff, path:config[:staff][:path] do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      # resources :session, only: [ :create, :destroy ] # ログアウトで、IDを渡す必要がある
      post 'session' => 'sessions#create', as: :session
      delete 'session' => 'sessions#destroy'
      resources :account, except: [ :new, :create, :destroy ]
    end
  end

  constraints host: config[:admin][:host] do
    namespace :admin, path:config[:admin][:path] do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      post 'session' => 'sessions#create', as: :session
      delete 'session' => 'sessions#destroy'
      resources :staff_members
      resources :staff_members do
        resources :staff_events, only: [:index]
      end
      resources :staff_events, only: [:index]
    end
  end

  constraints host: config[:customer][:host] do
    namespace :customer, path:config[:customer][:path] do
      root 'top#index'
    end
  end
end
