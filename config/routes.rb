Rails.application.routes.draw do
  root 'landing#index'
 
  resources :links, only: [:create]
  
end
