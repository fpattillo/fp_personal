Rails.application.routes.draw do

  devise_for :users
  resources :users
  root "users#index"

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      root "users#index"
      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
      end
      #resources :conversations
      get 'conversations/redirect_or_create/:other_user_id' =>
        'conversations#redirect_or_create',
        as: 'redirect_or_create'
      get 'conversations/:id' => 'conversations#show',
        as: 'conversation'
      post 'conversations/new_room' =>
        'conversations#new_room',
        as: 'new_room'
      post 'conversations/:id/new_message' =>
        'conversations#new_message',
        as: 'new_message'
      mount ActionCable.server => '/cable'
    end
  end

  

  resources :conversations
  get 'conversations/redirect_or_create/:other_user_id' =>
    'conversations#redirect_or_create',
    as: 'redirect_or_create'
  post 'conversations/:id/new_message' =>
    'conversations#new_message',
    as: 'new_message'
  post 'conversations/new_room' =>
    'conversations#new_room',
    as: 'new_room'
  mount ActionCable.server => '/cable'
end
