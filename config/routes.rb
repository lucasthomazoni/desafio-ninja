# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :rooms, only: :index
  resources :users, only: :index

  resources :meets, only: %i[index create show update destroy] do
    post :cancel
  end
end
