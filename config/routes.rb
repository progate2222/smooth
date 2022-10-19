Rails.application.routes.draw do
  get 'users/show'
  resources :teams
  resources :team_members, only: [:create, :destroy, :index]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
}
  resources :users, only: [:show]
  resources :tasks do
    collection do
      get 'search'
    end
  end
  root 'tasks#index'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/guest_admin_sign_in', to: 'users/sessions#guest_admin_sign_in'
  end

end
