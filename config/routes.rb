Rails.application.routes.draw do
  resources :events do
    get :subscribe, on: :member
  end
  devise_for :users

  root to: "events#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
