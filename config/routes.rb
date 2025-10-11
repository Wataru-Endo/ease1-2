Rails.application.routes.draw do
  # ログイン関連
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'  # ← この行を追加
  
  # ユーザー関連
  resources :users, only: [:new, :create, :show, :edit, :update]

  # 症状関連
  resources :symptoms, only: [:index, :show, :edit, :update]

  # エクササイズ関連
  resources :exercises, only: [:index, :show, :edit, :update]

  # ルートページ（ログイン後の最初のページ）
  root 'sessions#new'
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, or 500 otherwise.
  get "up" => "rails/health#show", as: :rails_health_check
end
