Rails.application.routes.draw do
  get "static_pages/credits"
  get "delayed_job_sites/pull_delayed_jobs"
  resources :delayed_jobs
  resources :delayed_job_sites
  root to: "static_pages#credits"
end
