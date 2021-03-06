require 'resque/server'

Rails.application.routes.draw do

  get 'schedules/setup'
  post 'schedules/setup'

  get 'lists/setup'
  post 'lists/setup'

  get 'accounts/setup'
  post 'accounts/setup'

  root to: 'lists#setup'

  mount Resque::Server.new, at: "/resque"

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get '/sign_in' => 'devise/sessions#new'
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, :controllers => {
   :registrations => 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
