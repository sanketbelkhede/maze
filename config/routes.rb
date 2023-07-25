Rails.application.routes.draw do
  get 'users/download_csv', to: 'users#download_csv'
  get 'articles/download_csv', to: 'articles#download_csv'
  get 'users/download_xlsx', to: 'users#download_xlsx'
  get 'articles/download_xlsx', to: 'articles#download_xlsx'

  get 'users/download_10_csv', to: 'users#download_10_csv'

  root to: "home#index"
  resources :articles do

    resources :comments, only: [:create]

  end
  post '/articles/:article_id/create_comment', to: 'comments#create_comment'

  get 'myarticles', to: 'articles#myarticles'
  patch 'myarticles/:id/private', to: 'articles#private'
  patch 'myarticles/:id/public', to: 'articles#public'
  
  resources :likes, only: [:create, :destroy]
  # post '/likes/create_like', to: 'likes#create_like'
  # delete '/likes/:id/destroy_like', to: 'likes#destroy_like'

  # get '/articles', to: 'articles#index'
  # post '/articles', to: 'articles#create'
  # get '/articles/new', to: 'articles#new'
  # get '/articles/:id/edit', to: 'articles#edit'
  # get '/articles/:id', to: 'articles#show'
  # patch '/articles/:id', to: 'articles#update'
  # put '/articles/:id', to: 'articles#update'
  # delete '/articles/:id', to: 'articles#destroy'

  # post '/articles/:article_id/comments', to: 'comments#create'


  # post '/likes', to: 'likes#create'
  # delete '/likes/:id', to: 'likes#destroy'


  get '/register', to: 'users#new'

  get 'admin', to: 'admin#index'
  post 'admin/import', to: 'admin#import'
  patch 'admin/:id/activate_user', to: 'admin#activate_user'
  patch 'admin/:id/deactivate_user', to: 'admin#deactivate_user'
  get 'admin/create_user/new', to: 'admin#new'
  get 'admin/manage_users', to: 'admin#manage_users'
  get 'admin/reports', to: 'admin#reports'
  get 'admin/upload_users', to: 'admin#upload_users'
  post 'admin/create_user', to: 'admin#create_user'


  resources :users, only: [:index, :new, :create, :show]
  # post '/users', to: 'users#create'


  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'

  resources :sessions, only: [:create]
  # post '/sessions', to: 'sessions#create'
end
