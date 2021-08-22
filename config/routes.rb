# Rails.application.routes.draw do
#   get 'spa/index'
#   resources :users
#   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
# end
# 以下に修正
Rails.application.routes.draw do
  root 'spa#index'
  resources :users,only: [:index, :create, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end