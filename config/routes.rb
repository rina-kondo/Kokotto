Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :public do
    root to: 'homes#top'
    get "about" => "homes#about", as: 'about'
    patch "withdrawal" => "users#withdrawal", as: "public_withdrawal"
    resources :users, only: [:show, :edit, :update]
    resources :posts, only: [:new, :create, :index, :show, :destroy] do
      resource :likes, only: [:index]
      resources :comments, only: [:new, :create, :destroy]
    end
  end

  namespace :admin do
    get '/' => 'homes#top', as: "admin"
    patch "withdrawal" => "users#withdrawal", as: "admin_withdrawal"
    resources :users, only: [:show]
    resources :comments, only: [:show, :destroy]
  end

end
