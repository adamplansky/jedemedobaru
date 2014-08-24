Rails.application.routes.draw do
  resource :contacts, only: [:new, :create]
  
  root to: 'contacts#new'
end
