Rails.application.routes.draw do
  root to: "homes#top"
  get "home/about", to: "homes#about"
end
