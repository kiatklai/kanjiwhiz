Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'

  resources :users, only: [:show, :edit, :update]
  # 問題の一覧表示
  resources :questions, only: [:index, :new, :create, :destroy]
  #テスト結果が表示される
  get 'test_results/result', to: 'test_results#result'
  # テストの表示と回答のチェック
  get 'tests/show', to: 'tests#show'
  post 'tests/answer', to: 'tests#answer'
end
