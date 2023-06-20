Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'

  resources :users, only: [:show, :edit, :update]
  # 問題の一覧表示
  resources :questions, only: [:index, :new, :create, :destroy]
end
