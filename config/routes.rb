Rails.application.routes.draw do
  devise_for :users, path: "secure"
  root "entries#index"
  get "/home", to: "pages#home"
  get "/about", to: "pages#about"
  resources :entries

  namespace :api do
    namespace :v1 do
      post :auth, to: "auth#create"
      resources :entries, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
