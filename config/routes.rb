Rails.application.routes.draw do
  root 'posts#index'
  resources :posts, only: [:index, :create, :destroy]
  scope '/api' do
    get 'analyze_text/' => 'api#analyze_text'
  end
end
