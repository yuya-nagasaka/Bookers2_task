Rails.application.routes.draw do
  resources :users, only: [:show,:index,:edit,:update]
  resources :books
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
end