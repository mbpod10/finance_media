Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy] 
  get 'user/:id/friends', to: 'friendships#friends_list', as: :friends_list
  # get 'user/:user_id/stock/:stock_id', to: 'stocks#show', as: :user_show_stock
  get 'user/:user_id/stock/:ticker', to: 'stocks#show', as: :user_show_stock
  devise_for :users
  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
end
