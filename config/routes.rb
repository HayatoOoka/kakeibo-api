Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  post 'login', to: 'sessions#create'
  resources :organizations do 
    resources :users
  end
  resources :accounts do
    resources :transactions
  end  
  resources :users do
    member do
      get 'transactions'
    end
  end    
  resources :users
  resources :accounts
end
