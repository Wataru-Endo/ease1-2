Rails.application.routes.draw do
  get "dashboard", to: "dashboard#show", as: :dashboard
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  health_check_path = ENV.fetch("HEALTH_CHECK_PATH") { "/up" }
  get health_check_path, to: "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"

  # ユーザー認証
  resources :users, except: [ :index ]

  # ログイン・ログアウト
  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout
  post "/dev_login", to: "sessions#dev_login", as: :dev_login

  # 症状
  resources :symptoms

  # エクササイズ
  resources :exercises do
    member do
      post :favorite, to: "favorites#create"
      delete :unfavorite, to: "favorites#destroy"
    end
  end

  # お気に入り一覧
  resources :favorites, only: [ :index, :show, :create, :destroy ]

  # スケジュール
  resources :schedules

  # 管理者ページ
  namespace :admin do
    resources :users, only: [ :index, :show, :edit, :update, :destroy ]
    resources :exercises
    resources :symptoms
  end
end
