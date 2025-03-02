Rails.application.routes.draw do
  resources :books do
    member do
      post :borrow
      post :return
    end
  end

  resources :borrowers, only: [:index, :show]
  
  root "books#index"
end


