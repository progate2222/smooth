Rails.application.routes.draw do
  devise_for :users
  resources :tasks
  root 'tasks#index'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
