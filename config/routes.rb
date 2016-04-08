Rails.application.routes.draw do
 devise_for :users, :controllers => { registrations: 'registrations', sessions: "users/sessions",  :omniauth_callbacks => "omniauth_callbacks" }
 # devise_for :users, controllers: { sessions: "users/sessions" }
  
  authenticated :user do
    root 'users#index'
    get 'games' => 'users#games'
  end
 
  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end
 
  post 'playing' => 'conversations#new'
  resources :conversations do
    resources :messages
  end

end
