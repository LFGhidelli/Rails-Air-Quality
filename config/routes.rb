Rails.application.routes.draw do
  # get 'home/zipcode'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'zipcode' => 'home#zipcode'
end
