Rails.application.routes.draw do
  
  root 'static_pages#home'
  
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  resources :books
  
  get '/:username/books', to: "books#public_profile", as: "user_public_profile"
  get '/books/:id/download_md_note', to: "books#download_md_note", as: "book_download_md_note"
  get '/books/:id/start_reading', to: "books#start_reading", as: "book_start_reading"
  get '/books/:id/finish_reading', to: "books#finish_reading", as: "book_finish_reading"
  
end
