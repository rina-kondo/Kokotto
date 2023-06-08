Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: 'homes#top'
    get "about" => "homes#about", as: 'about'
    patch "withdrawal" => "users#withdrawal"
    get 'mypage' => 'users#mypage'
    get 'user/information/edit', to: 'users#edit', as: 'edit_user'
    patch 'user/information', to: 'users#update', as: 'update_user'
    resources :posts, only: [:new, :create, :show, :destroy] do
      resources :likes, only: [:create, :destroy, :index]
      resources :comments, only: [:new, :create, :destroy]
    end
  end

  namespace :admin do
    get '/' => 'homes#top', as: "admin"
    resources :users, only: [:show, :edit, :update]
    resources :comments, only: [:show, :destroy]
  end

end
