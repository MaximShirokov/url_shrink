Rails.application.routes.draw do
  root to: 'short_links#new'

  scope '' do
    get ':short_code', to: 'short_links#show',  as: :short_link
    get ':short_code/stats', to: 'short_link_stats#show', as: :short_link_stats
  end

  resources :users, only: :create
  resources :user_sessions, only: :create

  resources :short_links, only: [:new, :create]

  get 'sign_in', to: 'user_sessions#new', :as => :sign_in
  get 'sign_up', to: 'users#new', :as => :sign_up
  delete 'sign_out' => 'user_sessions#destroy', :as => :sign_out
end
