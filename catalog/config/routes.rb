Rails.application.routes.draw do
  get 'companies/import', to: 'companies#import'
  resources :companies

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
