Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in', as: 'guest_sign_in'
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: 'homes#about'
    patch "withdrawal" => "users#withdrawal"
    get 'mypage' => 'users#mypage'
    get 'user/information/edit', to: 'users#edit', as: 'edit_user'
    get 'user/liked_posts', to: 'users#liked_posts', as: 'liked_posts'
    patch 'user/information', to: 'users#update', as: 'update_user'
    resources :posts, only: [:new, :create, :index, :show, :destroy] do
      resource :like, only: [:create, :destroy]
    end
    scope '/posts/:post_id' do
      resources :comments, only: [:new, :create, :destroy]
    end
  end

  namespace :admin do
    get '/' => 'homes#top', as: "admin"
    resources :users, only: [:show, :edit, :update]
    resources :comments, only: [:show, :destroy]
  end

end
