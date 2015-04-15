Rails.application.routes.draw do
  get "static_pages/credits"
  root to: "static_pages#credits"
end
