Rails.application.routes.draw do

  get 'admin', to: 'admin#index'

  controller :sessions do
    get 'login', to: :new
    post 'login_processing', to: :create
    delete 'logout', to: :destroy
  end

  resources :users

  resources :orders

  resources :line_items do
    post :decrement, on: :member
  end

  resources :carts
  resources :products do
    get :who_bought, on: :member
  end

  root 'store#index', as: 'store'
end
