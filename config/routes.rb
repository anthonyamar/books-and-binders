Rails.application.routes.draw do
  
  root 'static_pages#home'
  
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  resources :books
  
  get '/:username/books', to: "books#public_profile", as: "user_public_profile"
  get '/books/:id/download_md_note', to: "books#download_md_note", as: "book_download_md_note"
  
end
