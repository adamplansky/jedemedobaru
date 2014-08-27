Rails.application.routes.draw do
  resource :contacts, only: [:new, :create]
  resources :blog, only: [:index]
  root to: 'contacts#new'
end
