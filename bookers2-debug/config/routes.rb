Rails.application.routes.draw do
   devise_for :users
  resources :users, only: [:show,:index,:edit,:update]
  resources :books
 
  root 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
end