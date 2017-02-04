Rails.application.routes.draw do
  root 'posts#index'
  resources :posts, only: [:index, :create, :destroy]
  get 'posts/api', to: 'posts#get_api'
end
