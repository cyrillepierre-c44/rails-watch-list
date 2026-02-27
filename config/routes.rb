Rails.application.routes.draw do
  resources :lists, only: [ :index, :new, :create, :show, :destroy ] do
    root to: "lists#index"
    resources :bookmarks, only: [ :new, :create, :destroy ]
  end
end
