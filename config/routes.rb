Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'

  # 管理者専用の登録フォーム
  get 'users/new_admin', to: 'users#new_admin'
  post 'users/create_admin', to: 'users#create_admin'
  resources :users, only: [:show, :edit, :update]
  # 問題の一覧表示
  resources :questions, only: [:index, :new, :create, :destroy]
end
