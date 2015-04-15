Rails.application.routes.draw do
  get "static_pages/credits"
  get "delayed_jobs/pull_delayed_jobs"
  root to: "static_pages#credits"
end
