ChessCamp::Application.routes.draw do
  # generated routes
  resources :curriculums
  resources :instructors
  resources :camps
  resources :families
  resources :students
  resources :users
  resources :locations
  resources :registrations

  # the path to generate reports
  get 'camps/:id/report' => 'camps#report', as: :report_camp
  get 'registrations/:id/report' => 'registrations#report', as: :report_family
  get 'families/:id/report' => 'families#report', as: :report_year

  # semi-static routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  get 'home/year', to: 'home#year', as: :year

  # set the root url
  root to: 'home#index'

  resources :users
  resources :sessions
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout

end
