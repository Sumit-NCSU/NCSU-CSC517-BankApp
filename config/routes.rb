Rails.application.routes.draw do

  get 'users', to: 'users#index_users'
  get 'admins', to: 'users#index_admins'
  get 'sessions/new'
  get 'home' => 'sessions#index'
  get 'signup' => 'users#new'
  get 'admin/new' => 'users#new_admin'
  post 'admin/new' => 'users#create_admin'
  get 'login'   => 'sessions#new'
  post 'login'   => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get 'manage' => 'transactions#manage'
  get 'withdraw' => 'transactions#withdraw'
  get 'deposit' =>  'transactions#deposit'
  get 'borrow' => 'transactions#borrow'
  get 'lend' => 'transactions#lend'
  delete 'logout' => 'sessions#destroy'
  post 'deposit' => 'transactions#create_deposit'
  post 'withdraw' => 'transactions#create_withdraw'
  post 'borrow' => 'transactions#create_borrow'
  post 'lend' => 'transactions#create_lend'
  put 'approve' => 'transactions#approve'
  put 'decline' => 'transactions#decline'
  get 'friends/search' => 'friends#search'

  resources :users
  resources :accounts
  resources :friends
  resources :transactions
  resources :account_requests

  root 'sessions#new'
end
