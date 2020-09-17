Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'items/new'
  post 'items/new', action: :create, controller: 'items'
  get 'items', action: :index, controller: 'items'
  delete 'items/:id', action: :destroy, controller: 'items'
  get 'items/:id/edit', action: :edit, controller: 'items'
  patch 'items/:id', action: :update, controller: 'items'
  put 'items/:id', action: :update, controller: 'items'

  root 'items#index'
end
