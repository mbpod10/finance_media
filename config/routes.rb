Rails.application.routes.draw do 
  resources :user_stocks, only: [:create, :destroy] 
  get 'user/:id/friends', to: 'friendships#friends_list', as: :friends_list
  get 'user/:user_id/stock/:ticker', to: 'stocks#show', as: :user_show_stock
  get 'friend_search', to: 'users#search'
  devise_for :users
  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  resources :stocks
  get 'search_stock', to: 'stocks#search'
  resources :friendships, only: [:create, :destroy]
  resources :users, only: [:show]
  # get 'portfolio_refresh', to: 'users#portfolio_refresh'
  
  mount ActionCable.server, at: '/cable'
end
