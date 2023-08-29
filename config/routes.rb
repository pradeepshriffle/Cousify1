Rails.application.routes.draw do
  post 'user_login', to: 'users#user_login'
  resource :users do
  resources :categories  
  resources :courses
  resources :subscriptions
 
end

 resource :users do
  get 'search_course_name', to: 'courses#search_course_name'
  get 'search_course_status', to: 'courses#search_course_status'
  get 'show_active_course', to: 'courses#show_active_course'
 end

  match "*path", to: "application#render_404", via: :all
end
