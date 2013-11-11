Warehouse::Application.routes.draw do
  resources :boxes
  resources :products

  resource :pack, only: [:new, :create], controller: 'pack'

  root 'pack#new'
end
