Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#show'

  resources :users, only: [:create, :show, :index]
  resources :messages, only: [:create, :show] do
    collection do
      get :show_all
      put :trash
      put :sent
      put :inbox
      put :draft
      put :mark
    end
  end

end
