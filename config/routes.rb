Rails.application.routes.draw do
  root 'landing#index'
 
  resources :links, only: [:create]

  get '/:code', to: 'links#redirect'
  
end
