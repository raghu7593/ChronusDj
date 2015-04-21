Rails.application.routes.draw do
  root to: "sessions#new"
  get "/auth/google_oauth2/callback", to: "sessions#create"
  get "/auth/failure", to: "sessions#failure"
  get "/logout", to: "sessions#destroy", :as => "logout"
  get "/sl", to: "sessions#new_super_user"
  post "/sl", to: "sessions#create_super_user"
  resources :delayed_jobs
  resources :delayed_job_sites do
    collection do
      get :pull_delayed_jobs
    end
  end
end
