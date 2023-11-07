Rails.application.routes.draw do
  get 'actions/:id/execute', to: 'actions#execute'

  resources :actions, only: [:new, :destroy]

  resources :gpio, only: [:new, :create]
  resources :action_scheduler, only: [:create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
