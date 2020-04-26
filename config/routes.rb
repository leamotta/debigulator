Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'landing#index'
 
  resources :links, only: [:create]

  get '/:code', to: 'links#redirect'
  
  api_version(module: 'api/v1', path: { value: 'api/v1' }, defaults: { format: :json }) do
    resources :links, only: [:create]
  end
end
