Rails.application.routes.draw do

  post 'user_login', to: 'users#user_login'
  resource :users do
  resources :courses
  resources :subscriptions
  resources :categories

end

 resource :users do
  get 'search_course_name', to: 'courses#search_course_name'
  get 'search_program_status', to: 'courses#search_program_status'
  get 'show_active_course', to: 'courses#show_active_course'
  get 'show_category_wise_courses', to: 'courses#show_category_wise_courses'
 end

  match "*path", to: "application#render_404", via: :all
end
